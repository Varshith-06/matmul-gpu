#include "clkernels/softmax.hpp"

#include <stdexcept>

namespace clk {

namespace {

constexpr const char* kFile = "softmax.cl";
constexpr std::size_t kNaiveLocal = 64;  // softmax_naive: one work-item per row

}  // namespace

const std::vector<std::string>& RowKernel::names() {
  static const std::vector<std::string> n = {"softmax_naive", "softmax_wg",  "softmax_online",
                                             "softmax_cached", "layernorm", "layernorm_naive"};
  return n;
}

RowKernel::RowKernel(Env& e, std::string kernel, std::string opts)
    : env_(e), kernel_(std::move(kernel)), opts_(std::move(opts)) {
  bool known = false;
  for (const auto& n : names()) known |= n == kernel_;
  if (!known) throw std::invalid_argument("unknown row kernel '" + kernel_ + "'");

  const int wg = define_value(opts_, "WG", 256);
  if (wg <= 0 || (wg & (wg - 1))) {
    why_ = "WG must be a power of two";
    return;
  }
  wg_ = std::size_t(wg);
  local_ = kernel_ == "softmax_naive" ? kNaiveLocal : wg_;
  if (local_ > e.max_work_group()) {
    why_ = std::to_string(local_) + " work-items > CL_DEVICE_MAX_WORK_GROUP_SIZE (" +
           std::to_string(e.max_work_group()) + ")";
    return;
  }
  built_ = &e.build(kFile, opts_);
  k_ = cl::Kernel(built_->program, kernel_.c_str());
}

std::string RowKernel::invalid(int cols) const {
  if (!why_.empty() || kernel_ != "softmax_cached") return why_;
  // The row plus the reduction array must fit in local memory.
  const std::size_t need = (std::size_t(cols) + wg_) * sizeof(float);
  if (need > env_.local_mem())
    return "row of " + std::to_string(cols) + " floats does not fit in " +
           std::to_string(env_.local_mem()) + " B of local memory (use softmax_online)";
  return {};
}

cl::NDRange RowKernel::global(int R) const {
  if (kernel_ == "softmax_naive") return cl::NDRange(round_up(std::size_t(R), kNaiveLocal));
  return cl::NDRange(std::size_t(R) * wg_);  // one work-group per row
}

double RowKernel::softmax(int R, int C, float scale, const cl::Buffer& x, cl::Buffer& y) {
  if (is_layernorm()) throw std::logic_error(kernel_ + " is a layer norm kernel");
  if (const std::string why = invalid(C); !why.empty()) throw std::logic_error(kernel_ + ": " + why);
  k_.setArg(0, R);
  k_.setArg(1, C);
  k_.setArg(2, scale);
  k_.setArg(3, x);
  k_.setArg(4, y);
  if (kernel_ == "softmax_cached") k_.setArg(5, cl::Local(std::size_t(C) * sizeof(float)));
  return launch_ms(env_, k_, global(R), cl::NDRange(local_));
}

double RowKernel::layernorm(int R, int C, float eps, const cl::Buffer& x, const cl::Buffer& gamma,
                            const cl::Buffer& beta, cl::Buffer& y) {
  if (!is_layernorm()) throw std::logic_error(kernel_ + " is not a layer norm kernel");
  if (!why_.empty()) throw std::logic_error(kernel_ + ": " + why_);
  k_.setArg(0, R);
  k_.setArg(1, C);
  k_.setArg(2, eps);
  k_.setArg(3, x);
  k_.setArg(4, gamma);
  k_.setArg(5, beta);
  k_.setArg(6, y);
  return launch_ms(env_, k_, global(R), cl::NDRange(local_));
}

PtxasInfo RowKernel::ptxas() const {
  return built_ ? ptxas_info(built_->log, kernel_) : PtxasInfo{};
}

std::string RowKernel::binary() const {
  return built_ ? program_binary(built_->program) : std::string();
}

}  // namespace clk
