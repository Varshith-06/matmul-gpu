// Kernel 3 (2D register blocking) from kernels/gemm.cl, translated to HIP line for line.
// The OpenCL -D options become template parameters, so one binary holds every configuration of
// the tuning sweep and the compiler still sees constants (loops unroll, arrays live in registers).
//
//   OpenCL                         HIP
//   __local                        __shared__
//   barrier(CLK_LOCAL_MEM_FENCE)   __syncthreads()
//   get_local_id(0 / 1)            threadIdx.x / threadIdx.y
//   get_group_id(0 / 1)            blockIdx.x / blockIdx.y
//   -DCONTIG=1                     template parameter CONTIG
//
// Launch: block (RTSN, RTSM), grid (ceil(N / TSN), ceil(N / TSM)). Dimension x = columns, as in
// OpenCL, so consecutive lanes of a wavefront read consecutive B and write consecutive C.
// Nothing here depends on the wavefront size (no cross-lane operations).

#pragma once

#include <hip/hip_runtime.h>

namespace clk::hip {

// The rules check_config() enforces on the host (gemm_hip.cpp); a configuration that breaks them
// is never instantiated, the same way the OpenCL host never builds it.
template <int TSM, int TSN, int TSK, int WPTM, int WPTN>
__host__ __device__ constexpr bool divisible() {
  constexpr int nwi = (TSM / WPTM) * (TSN / WPTN);
  return TSM % WPTM == 0 && TSN % WPTN == 0 && (TSM * TSK) % nwi == 0 && (TSK * TSN) % nwi == 0;
}

// __launch_bounds__ tells the compiler the real block size. Without it, AMD's compiler assumes a
// block can have 1,024 threads and caps registers to fit that, which would spill the 8 x 8 blocks.
// NVIDIA's OpenCL compiler has no such cap, so this keeps the comparison about the kernel itself.
template <int TSM, int TSN, int TSK, int WPTM, int WPTN, bool CONTIG>
__global__ void __launch_bounds__((TSM / WPTM) * (TSN / WPTN))
gemm_reg(const int N, const float* A, const float* B, float* C) {
  constexpr int RTSM = TSM / WPTM;         // block rows
  constexpr int RTSN = TSN / WPTN;         // block columns
  constexpr int NWI = RTSM * RTSN;         // threads per block
  constexpr int LPTA = (TSM * TSK) / NWI;  // A elements each thread loads per tile
  constexpr int LPTB = (TSK * TSN) / NWI;  // B elements each thread loads per tile
  static_assert(divisible<TSM, TSN, TSK, WPTM, WPTN>(), "configuration breaks kernel 3's rules");

  const int tx = threadIdx.x, ty = threadIdx.y;
  const int tid = ty * RTSN + tx;
  const int rowBase = blockIdx.y * TSM;
  const int colBase = blockIdx.x * TSN;
  // Strided: consecutive tx own consecutive columns. Contiguous: a wavefront's reads of Bs are
  // WPTN floats apart.
  auto ownRow = [&](int m) { return CONTIG ? ty * WPTM + m : ty + m * RTSM; };
  auto ownCol = [&](int n) { return CONTIG ? tx * WPTN + n : tx + n * RTSN; };

  __shared__ float As[TSM][TSK];
  __shared__ float Bs[TSK][TSN];
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
    __syncthreads();

    for (int k = 0; k < TSK; ++k) {
      for (int m = 0; m < WPTM; ++m) aReg[m] = As[ownRow(m)][k];
      for (int n = 0; n < WPTN; ++n) bReg[n] = Bs[k][ownCol(n)];
      for (int m = 0; m < WPTM; ++m)
        for (int n = 0; n < WPTN; ++n)
          acc[m][n] += aReg[m] * bReg[n];  // WPTM * WPTN FMAs per WPTM + WPTN LDS loads
    }
    __syncthreads();
  }

  for (int m = 0; m < WPTM; ++m)
    for (int n = 0; n < WPTN; ++n) {
      const int gr = rowBase + ownRow(m), gc = colBase + ownCol(n);
      if (gr < N && gc < N) C[gr * N + gc] = acc[m][n];
    }
}

}  // namespace clk::hip
