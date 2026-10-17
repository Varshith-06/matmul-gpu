// Row-wise softmax and layer norm over an R x C row-major matrix. These kernels are memory-bound:
// the goal is to read and write as few bytes as possible, coalesced.
//
// softmax: y_j = exp(s*x_j - m) / sum_k exp(s*x_k - m), with m the row maximum of s*x and s a
// scale factor (1 for plain softmax, 1/sqrt(d) when attention fuses its scale pass in here).
// Subtracting m changes nothing mathematically but keeps exp from overflowing.

#ifndef WG
#define WG 256  // work-group size for the row-per-group kernels; must be a power of two
#endif

// ---------------------------------------------------------------------------------------------
// Variant 1: one work-item per row. Neighbouring work-items read addresses C floats apart, and
// with few rows most of the GPU sits idle. Launch: global round_up(R, 64), local 64.
// ---------------------------------------------------------------------------------------------
__kernel void softmax_naive(const int R, const int C, const float scale,
                            __global const float* x, __global float* y) {
  const int row = get_global_id(0);
  if (row >= R) return;
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;
  float m = -INFINITY;
  for (int j = 0; j < C; ++j) m = fmax(m, scale * xr[j]);
  float s = 0.0f;
  for (int j = 0; j < C; ++j) s += exp(scale * xr[j] - m);
  const float inv = 1.0f / s;
  for (int j = 0; j < C; ++j) yr[j] = exp(scale * xr[j] - m) * inv;
}

// Tree reductions over WG values in local memory. Every work-item must call these (they contain
// barriers); each returns the reduced value to all work-items and leaves `red` free for reuse.
float reduce_max(__local float* red, float v) {
  const int lid = get_local_id(0);
  red[lid] = v;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (int s = WG / 2; s > 0; s >>= 1) {
    if (lid < s) red[lid] = fmax(red[lid], red[lid + s]);
    barrier(CLK_LOCAL_MEM_FENCE);  // outside the if: every work-item reaches it
  }
  const float r = red[0];
  barrier(CLK_LOCAL_MEM_FENCE);  // all have read red[0] before it is reused
  return r;
}

float reduce_sum(__local float* red, float v) {
  const int lid = get_local_id(0);
  red[lid] = v;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (int s = WG / 2; s > 0; s >>= 1) {
    if (lid < s) red[lid] += red[lid + s];
    barrier(CLK_LOCAL_MEM_FENCE);
  }
  const float r = red[0];
  barrier(CLK_LOCAL_MEM_FENCE);
  return r;
}

// ---------------------------------------------------------------------------------------------
// Variant 2: one work-group per row, three coalesced passes (max, sum, write): 3 reads + 1 write.
// Launch: global R * WG, local WG.
// ---------------------------------------------------------------------------------------------
__kernel void softmax_wg(const int R, const int C, const float scale,
                         __global const float* x, __global float* y) {
  __local float red[WG];
  const int row = get_group_id(0), lid = get_local_id(0);
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;

  float m = -INFINITY;  // pass 1: row max; neighbouring work-items read neighbouring floats
  for (int j = lid; j < C; j += WG) m = fmax(m, scale * xr[j]);
  m = reduce_max(red, m);

  float s = 0.0f;  // pass 2: sum of exponentials
  for (int j = lid; j < C; j += WG) s += exp(scale * xr[j] - m);
  const float inv = 1.0f / reduce_sum(red, s);

  for (int j = lid; j < C; j += WG)  // pass 3: write
    yr[j] = exp(scale * xr[j] - m) * inv;
}

// ---------------------------------------------------------------------------------------------
// Variant 3: online softmax. A running maximum with the running sum rescaled whenever the maximum
// grows gives (max, sum) in one pass: 2 reads + 1 write. This is FlashAttention's building block.
// Launch: global R * WG, local WG.
// ---------------------------------------------------------------------------------------------

// Combine two partial (max, sum) pairs. When both maxima are -INFINITY (work-items that saw no
// elements, which happens when C < WG), exp(-inf - (-inf)) would be NaN: the sum is 0 instead.
void combine(float m1, float s1, float m2, float s2, float* m, float* s) {
  const float mn = fmax(m1, m2);
  *s = (mn == -INFINITY) ? 0.0f : s1 * exp(m1 - mn) + s2 * exp(m2 - mn);
  *m = mn;
}

void reduce_online(__local float* redm, __local float* reds, float* m, float* s) {
  const int lid = get_local_id(0);
  redm[lid] = *m;
  reds[lid] = *s;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (int k = WG / 2; k > 0; k >>= 1) {
    if (lid < k) {
      float mm, ss;
      combine(redm[lid], reds[lid], redm[lid + k], reds[lid + k], &mm, &ss);
      redm[lid] = mm;
      reds[lid] = ss;
    }
    barrier(CLK_LOCAL_MEM_FENCE);
  }
  *m = redm[0];
  *s = reds[0];
}

__kernel void softmax_online(const int R, const int C, const float scale,
                             __global const float* x, __global float* y) {
  __local float redm[WG], reds[WG];
  const int row = get_group_id(0), lid = get_local_id(0);
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;

  float m = -INFINITY, s = 0.0f;  // pass 1 replaces the separate max and sum passes
  for (int j = lid; j < C; j += WG) {
    const float v = scale * xr[j];
    const float mn = fmax(m, v);
    s = s * exp(m - mn) + exp(v - mn);  // rescale the old sum to the new maximum
    m = mn;
  }
  reduce_online(redm, reds, &m, &s);
  const float inv = 1.0f / s;

  for (int j = lid; j < C; j += WG) yr[j] = exp(scale * xr[j] - m) * inv;
}

// ---------------------------------------------------------------------------------------------
// Stretch: the row is read from global memory once into local memory (1 read + 1 write), so it
// works only while C floats fit next to the reduction arrays; the host checks and refuses
// otherwise. `rowbuf` is a dynamic local allocation of C floats.
// Launch: global R * WG, local WG.
// ---------------------------------------------------------------------------------------------
__kernel void softmax_cached(const int R, const int C, const float scale,
                             __global const float* x, __global float* y,
                             __local float* rowbuf) {
  __local float red[WG];
  const int row = get_group_id(0), lid = get_local_id(0);
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;

  float m = -INFINITY;
  for (int j = lid; j < C; j += WG) {
    const float v = scale * xr[j];
    rowbuf[j] = v;  // each work-item later rereads only its own elements: no barrier needed
    m = fmax(m, v);
  }
  m = reduce_max(red, m);

  float s = 0.0f;
  for (int j = lid; j < C; j += WG) {
    const float e = exp(rowbuf[j] - m);
    rowbuf[j] = e;
    s += e;
  }
  const float inv = 1.0f / reduce_sum(red, s);

  for (int j = lid; j < C; j += WG) yr[j] = rowbuf[j] * inv;
}

// ---------------------------------------------------------------------------------------------
// Layer norm: y = (x - mean) / sqrt(var + eps) * gamma + beta, per row; gamma and beta have C
// entries. One work-group per row. Launch: global R * WG, local WG.
// ---------------------------------------------------------------------------------------------

// Each work-item runs Welford's update over its elements, then the (count, mean, M2) triples are
// combined pairwise with Chan's formula. Both work with deviations from a running mean, so they
// stay accurate when the mean is large compared with the spread.
__kernel void layernorm(const int R, const int C, const float eps,
                        __global const float* x, __global const float* gamma,
                        __global const float* beta, __global float* y) {
  __local float rn[WG], rmean[WG], rm2[WG];
  const int row = get_group_id(0), lid = get_local_id(0);
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;

  float n = 0.0f, mean = 0.0f, m2 = 0.0f;
  for (int j = lid; j < C; j += WG) {
    const float v = xr[j];
    n += 1.0f;
    const float d = v - mean;
    mean += d / n;
    m2 += d * (v - mean);
  }
  rn[lid] = n;
  rmean[lid] = mean;
  rm2[lid] = m2;
  barrier(CLK_LOCAL_MEM_FENCE);
  for (int k = WG / 2; k > 0; k >>= 1) {
    if (lid < k) {
      const float na = rn[lid], nb = rn[lid + k], nab = na + nb;
      if (nb > 0.0f) {  // nothing to merge from an empty partner (C < WG)
        const float d = rmean[lid + k] - rmean[lid];
        rmean[lid] += d * (nb / nab);
        rm2[lid] += rm2[lid + k] + d * d * (na * nb / nab);
        rn[lid] = nab;
      }
    }
    barrier(CLK_LOCAL_MEM_FENCE);
  }
  mean = rmean[0];
  const float rstd = rsqrt(rm2[0] / (float)C + eps);

  for (int j = lid; j < C; j += WG) yr[j] = (xr[j] - mean) * rstd * gamma[j] + beta[j];
}

// The textbook alternative, var = E[x^2] - E[x]^2 from a sum and a sum of squares. Kept only to
// demonstrate the cancellation it suffers when the mean is large (tests print both errors).
__kernel void layernorm_naive(const int R, const int C, const float eps,
                              __global const float* x, __global const float* gamma,
                              __global const float* beta, __global float* y) {
  __local float red[WG];
  const int row = get_group_id(0), lid = get_local_id(0);
  __global const float* xr = x + (size_t)row * C;
  __global float* yr = y + (size_t)row * C;

  float s = 0.0f, sq = 0.0f;
  for (int j = lid; j < C; j += WG) {
    const float v = xr[j];
    s += v;
    sq += v * v;
  }
  const float mean = reduce_sum(red, s) / (float)C;
  const float var = reduce_sum(red, sq) / (float)C - mean * mean;
  const float rstd = rsqrt(var + eps);

  for (int j = lid; j < C; j += WG) yr[j] = (xr[j] - mean) * rstd * gamma[j] + beta[j];
}
