#pragma once

#include <string>
#include <vector>

#include "clkernels/env.hpp"

namespace clk {

// Row-wise kernels over an R x C matrix: softmax_naive, softmax_wg, softmax_online, softmax_cached,
// layernorm and layernorm_naive. Options: -DWG=<power of two> (default 256).
class RowKernel {
 public:
  RowKernel(Env& e, std::string kernel, std::string opts);

  // Empty if runnable for rows of length `cols` on this device, else why not.
  std::string invalid(int cols) const;

  // softmax: y = softmax(scale * x) row by row.
  double softmax(int R, int C, float scale, const cl::Buffer& x, cl::Buffer& y);
  // layer norm: y = (x - mean) / sqrt(var + eps) * gamma + beta row by row.
  double layernorm(int R, int C, float eps, const cl::Buffer& x, const cl::Buffer& gamma,
                   const cl::Buffer& beta, cl::Buffer& y);

  std::string local_str() const { return std::to_string(local_); }
  PtxasInfo ptxas() const;
  std::string binary() const;
  std::string build_log() const { return built_ ? built_->log : std::string(); }
  bool is_layernorm() const { return kernel_.rfind("layernorm", 0) == 0; }

  static const std::vector<std::string>& names();

 private:
  cl::NDRange global(int R) const;

  Env& env_;
  std::string kernel_, opts_, why_;
  std::size_t wg_ = 256, local_ = 256;
  const Built* built_ = nullptr;
  cl::Kernel k_;
};

}  // namespace clk
