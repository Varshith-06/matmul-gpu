// FP32 GEMM, C = A * B, row-major. Square kernels take N; gemm_mnk is the general M x N x K form
// used by the attention step. Tunable sizes arrive as -D build options so the compiler sees
// constants: loops unroll fully and per-work-item arrays live in registers.

// ---------------------------------------------------------------------------------------------
// Kernel 1: naive. One work-item per element of C.
// Launch: global (round_up(N, LX), round_up(N, LY)), local (LX, LY).
// ---------------------------------------------------------------------------------------------
__kernel void gemm_naive(const int N,
                         __global const float* A,
                         __global const float* B,
                         __global float* C) {
  const int col = get_global_id(0);  // dimension 0 = column: neighbours in a warp read
  const int row = get_global_id(1);  //   neighbouring B[k][col] and write neighbouring C
  if (row >= N || col >= N) return;  // padding work-items; no barrier here, so return is safe
  float acc = 0.0f;
  for (int k = 0; k < N; ++k)
    acc += A[row * N + k] * B[k * N + col];
  C[row * N + col] = acc;
}

// Identical arithmetic with the two indices swapped: the 32 work-items of a warp now have 32
// different rows, so each A load and each C store is strided by N floats. Kept as an experiment.
__kernel void gemm_naive_bad(const int N,
                             __global const float* A,
                             __global const float* B,
                             __global float* C) {
  const int row = get_global_id(0);
  const int col = get_global_id(1);
  if (row >= N || col >= N) return;
  float acc = 0.0f;
  for (int k = 0; k < N; ++k)
    acc += A[row * N + k] * B[k * N + col];
  C[row * N + col] = acc;
}

// ---------------------------------------------------------------------------------------------
// Kernel 2: TS x TS tiles of A and B in local memory, each value reused TS times.
// Build with -DTS=16. Launch: global (round_up(N, TS), round_up(N, TS)), local (TS, TS).
// ---------------------------------------------------------------------------------------------
#ifndef TS
#define TS 16
#endif

__kernel void gemm_tiled(const int N,
                         __global const float* A,
                         __global const float* B,
                         __global float* C) {
  const int lc = get_local_id(0), lr = get_local_id(1);
  const int col = get_global_id(0), row = get_global_id(1);
  __local float As[TS][TS];
  __local float Bs[TS][TS];
  float acc = 0.0f;

  // No early return: work-items past the edge still load zeros and reach both barriers.
  for (int t = 0; t < N; t += TS) {
    const int ac = t + lc;  // which column of A this work-item loads
    const int br = t + lr;  // which row of B this work-item loads
    As[lr][lc] = (row < N && ac < N) ? A[row * N + ac] : 0.0f;
    Bs[lr][lc] = (br < N && col < N) ? B[br * N + col] : 0.0f;
    barrier(CLK_LOCAL_MEM_FENCE);  // read-after-write: the tile is complete before anyone reads it

    for (int k = 0; k < TS; ++k)
      acc += As[lr][k] * Bs[k][lc];  // As: broadcast within a row; Bs: consecutive banks
    barrier(CLK_LOCAL_MEM_FENCE);  // write-after-read: all reads done before the next overwrite
  }
  if (row < N && col < N) C[row * N + col] = acc;
}

// ---------------------------------------------------------------------------------------------
// Kernel 3: 2D register blocking. A TSM x TSN tile of C per work-group, a WPTM x WPTN block of it
// per work-item, K consumed TSK at a time.
// Build with e.g. -DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4 (and -DCONTIG=1 for the variant
// in which each work-item owns a contiguous block instead of a strided one).
// Launch: local (RTSN, RTSM); global (ceil(N / TSN) * RTSN, ceil(N / TSM) * RTSM).
// ---------------------------------------------------------------------------------------------
#ifndef TSM
#define TSM 64
#endif
#ifndef TSN
#define TSN 64
#endif
#ifndef TSK
#define TSK 16
#endif
#ifndef WPTM
#define WPTM 4
#endif
#ifndef WPTN
#define WPTN 4
#endif

#define RTSM (TSM / WPTM)          // work-group rows
#define RTSN (TSN / WPTN)          // work-group columns
#define NWI (RTSM * RTSN)          // work-items per group
#define LPTA ((TSM * TSK) / NWI)   // A elements each work-item loads per tile
#define LPTB ((TSK * TSN) / NWI)   // B elements each work-item loads per tile

#if defined(CONTIG) && CONTIG
#define OWN_ROW(m) (ty * WPTM + (m))  // contiguous: a warp's reads are WPTN floats apart
#define OWN_COL(n) (tx * WPTN + (n))
#else
#define OWN_ROW(m) (ty + (m) * RTSM)  // strided: consecutive tx own consecutive columns
#define OWN_COL(n) (tx + (n) * RTSN)
#endif

__kernel void gemm_reg(const int N,
                       __global const float* A,
                       __global const float* B,
                       __global float* C) {
  const int tx = get_local_id(0), ty = get_local_id(1);
  const int tid = ty * RTSN + tx;
  const int rowBase = get_group_id(1) * TSM;
  const int colBase = get_group_id(0) * TSN;

  __local float As[TSM][TSK];
  __local float Bs[TSK][TSN];
  float acc[WPTM][WPTN];
  float aReg[WPTM], bReg[WPTN];
  for (int m = 0; m < WPTM; ++m)
    for (int n = 0; n < WPTN; ++n) acc[m][n] = 0.0f;

  for (int t = 0; t < N; t += TSK) {
    for (int l = 0; l < LPTA; ++l) {  // cooperative, coalesced tile loads
      const int idx = tid + l * NWI;
      const int r = idx / TSK, c = idx % TSK;
      const int gr = rowBase + r, gc = t + c;
      As[r][c] = (gr < N && gc < N) ? A[gr * N + gc] : 0.0f;
    }
    for (int l = 0; l < LPTB; ++l) {
      const int idx = tid + l * NWI;
      const int r = idx / TSN, c = idx % TSN;
      const int gr = t + r, gc = colBase + c;
      Bs[r][c] = (gr < N && gc < N) ? B[gr * N + gc] : 0.0f;
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int k = 0; k < TSK; ++k) {
      for (int m = 0; m < WPTM; ++m) aReg[m] = As[OWN_ROW(m)][k];
      for (int n = 0; n < WPTN; ++n) bReg[n] = Bs[k][OWN_COL(n)];
      for (int m = 0; m < WPTM; ++m)
        for (int n = 0; n < WPTN; ++n)
          acc[m][n] += aReg[m] * bReg[n];  // WPTM * WPTN FMAs per WPTM + WPTN local loads
    }
    barrier(CLK_LOCAL_MEM_FENCE);
  }

  for (int m = 0; m < WPTM; ++m)
    for (int n = 0; n < WPTN; ++n) {
      const int gr = rowBase + OWN_ROW(m), gc = colBase + OWN_COL(n);
      if (gr < N && gc < N) C[gr * N + gc] = acc[m][n];
    }
}

// Kernel 3 generalized to C[M x N] = A[M x K] * B[K x N], for the attention step.
// Same build options and work-group shape; global (ceil(N / TSN) * RTSN, ceil(M / TSM) * RTSM).
__kernel void gemm_mnk(const int M, const int N, const int K,
                       __global const float* A,
                       __global const float* B,
                       __global float* C) {
  const int tx = get_local_id(0), ty = get_local_id(1);
  const int tid = ty * RTSN + tx;
  const int rowBase = get_group_id(1) * TSM;
  const int colBase = get_group_id(0) * TSN;

  __local float As[TSM][TSK];
  __local float Bs[TSK][TSN];
  float acc[WPTM][WPTN];
  float aReg[WPTM], bReg[WPTN];
  for (int m = 0; m < WPTM; ++m)
    for (int n = 0; n < WPTN; ++n) acc[m][n] = 0.0f;

  for (int t = 0; t < K; t += TSK) {
    for (int l = 0; l < LPTA; ++l) {
      const int idx = tid + l * NWI;
      const int r = idx / TSK, c = idx % TSK;
      const int gr = rowBase + r, gc = t + c;
      As[r][c] = (gr < M && gc < K) ? A[gr * K + gc] : 0.0f;
    }
    for (int l = 0; l < LPTB; ++l) {
      const int idx = tid + l * NWI;
      const int r = idx / TSN, c = idx % TSN;
      const int gr = t + r, gc = colBase + c;
      Bs[r][c] = (gr < K && gc < N) ? B[gr * N + gc] : 0.0f;
    }
    barrier(CLK_LOCAL_MEM_FENCE);

    for (int k = 0; k < TSK; ++k) {
      for (int m = 0; m < WPTM; ++m) aReg[m] = As[OWN_ROW(m)][k];
      for (int n = 0; n < WPTN; ++n) bReg[n] = Bs[k][OWN_COL(n)];
      for (int m = 0; m < WPTM; ++m)
        for (int n = 0; n < WPTN; ++n)
          acc[m][n] += aReg[m] * bReg[n];
    }
    barrier(CLK_LOCAL_MEM_FENCE);
  }

  for (int m = 0; m < WPTM; ++m)
    for (int n = 0; n < WPTN; ++n) {
      const int gr = rowBase + OWN_ROW(m), gc = colBase + OWN_COL(n);
      if (gr < M && gc < N) C[gr * N + gc] = acc[m][n];
    }
}

// ---------------------------------------------------------------------------------------------
// Transpose through a local-memory tile: out[c][r] = in[r][c], in is R x C.
// Both the global read and the global write are coalesced; the +1 column of padding moves the
// column-wise read of the tile onto distinct banks. Build with -DTT=16.
// Launch: global (round_up(C, TT), round_up(R, TT)), local (TT, TT).
// ---------------------------------------------------------------------------------------------
#ifndef TT
#define TT 16
#endif

__kernel void transpose(const int R, const int C,
                        __global const float* in,
                        __global float* out) {
  __local float tile[TT][TT + 1];
  const int lx = get_local_id(0), ly = get_local_id(1);
  const int c = get_group_id(0) * TT + lx, r = get_group_id(1) * TT + ly;
  if (r < R && c < C) tile[ly][lx] = in[r * C + c];
  barrier(CLK_LOCAL_MEM_FENCE);
  const int oc = get_group_id(1) * TT + lx;  // output column = input row
  const int orow = get_group_id(0) * TT + ly;  // output row = input column
  if (orow < C && oc < R) out[orow * R + oc] = tile[lx][ly];
}

// Elementwise x *= s: the separate scale pass of unfused attention.
__kernel void scale(const int n, const float s, __global float* x) {
  const int i = get_global_id(0);
  if (i < n) x[i] *= s;
}
