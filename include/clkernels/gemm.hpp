#pragma once

#include <string>
#include <vector>

#include "clkernels/env.hpp"

namespace clk {

// One configured GEMM kernel: its build options, launch geometry and validity on this device.
//   gemm_naive, gemm_naive_bad   local size from `local` (e.g. {16, 16}; default 16 x 16)
//   gemm_tiled                   -DTS=8|16|32; local TS x TS
//   gemm_reg                     -DTSM -DTSN -DTSK -DWPTM -DWPTN [-DCONTIG=1]; local RTSN x RTSM
//   clblast                      CLBlast's row-major SGEMM, if built with it
class Gemm {
 public:
  Gemm(Env& e, std::string kernel, std::string opts, std::vector<std::size_t> local = {});

  // Empty if the configuration can run on this device; otherwise why not (bad tile arithmetic,
  // too many work-items, too much local memory). The host never launches an invalid point.
  const std::string& invalid() const { return why_; }

  // C = A * B for N x N buffers. Returns the kernel's GPU time in ms.
  double run(int N, const cl::Buffer& A, const cl::Buffer& B, cl::Buffer& C);

  // Local size as "16x16" for the CSV, ptxas register and spill counts, the PTX, the build log.
  std::string local_str() const;
  PtxasInfo ptxas() const;
  std::string binary() const;
  std::string build_log() const { return built_ ? built_->log : std::string(); }

  static const std::vector<std::string>& names();

 private:
  Env& env_;
  std::string kernel_, opts_, why_;
  std::size_t lx_ = 16, ly_ = 16;
  int tsm_ = 0, tsn_ = 0;  // tile per work-group, for the global size
  const Built* built_ = nullptr;
  cl::Kernel k_;
};

// The general M x N x K kernel-3 variant used by the attention step: C[M x N] = A[M x K] B[K x N].
double gemm_mnk(Env& e, const std::string& opts, int M, int N, int K, const cl::Buffer& A,
                const cl::Buffer& B, cl::Buffer& C);

// out (C x R) = transpose of in (R x C), through a local-memory tile.
double transpose(Env& e, int R, int C, const cl::Buffer& in, cl::Buffer& out);

// x[0:n] *= s.
double scale(Env& e, int n, float s, cl::Buffer& x);

// Empty if (TSM, TSN, TSK, WPTM, WPTN) satisfies kernel 3's divisibility rules and fits the
// device's work-group and local-memory limits; otherwise the first rule it breaks.
std::string check_reg_config(const Env& e, int tsm, int tsn, int tsk, int wptm, int wptn);

}  // namespace clk
