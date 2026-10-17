#include "clkernels/gemm.hpp"

#include <stdexcept>

namespace clk {

#ifdef CLK_HAVE_CLBLAST
double clblast_gemm(Env& e, int N, const cl::Buffer& A, const cl::Buffer& B, cl::Buffer& C);
#endif

namespace {

constexpr const char* kFile = "gemm.cl";

}  // namespace

const std::vector<std::string>& Gemm::names() {
  static const std::vector<std::string> n = {"gemm_naive", "gemm_naive_bad", "gemm_tiled",
                                             "gemm_reg",
#ifdef CLK_HAVE_CLBLAST
                                             "clblast"
#endif
  };
  return n;
}

std::string check_reg_config(const Env& e, int tsm, int tsn, int tsk, int wptm, int wptn) {
  if (tsm <= 0 || tsn <= 0 || tsk <= 0 || wptm <= 0 || wptn <= 0) return "sizes must be positive";
  if (tsm % wptm) return "TSM % WPTM != 0";
  if (tsn % wptn) return "TSN % WPTN != 0";
  const long nwi = long(tsm / wptm) * (tsn / wptn);
  if ((long(tsm) * tsk) % nwi) return "(TSM * TSK) % work-items != 0";
  if ((long(tsk) * tsn) % nwi) return "(TSK * TSN) % work-items != 0";
  if (std::size_t(nwi) > e.max_work_group())
    return std::to_string(nwi) + " work-items > CL_DEVICE_MAX_WORK_GROUP_SIZE (" +
           std::to_string(e.max_work_group()) + ")";
  const std::size_t lmem = (std::size_t(tsm) * tsk + std::size_t(tsk) * tsn) * sizeof(float);
  if (lmem > e.local_mem())
    return std::to_string(lmem) + " B of tiles > CL_DEVICE_LOCAL_MEM_SIZE (" +
           std::to_string(e.local_mem()) + ")";
  return {};
}

Gemm::Gemm(Env& e, std::string kernel, std::string opts, std::vector<std::size_t> local)
    : env_(e), kernel_(std::move(kernel)), opts_(std::move(opts)) {
  if (kernel_ == "clblast") {
#ifndef CLK_HAVE_CLBLAST
    why_ = "built without CLBlast";
#endif
    return;
  }
  if (kernel_ == "gemm_naive" || kernel_ == "gemm_naive_bad") {
    if (local.size() == 2) lx_ = local[0], ly_ = local[1];
    tsn_ = int(lx_), tsm_ = int(ly_);
  } else if (kernel_ == "gemm_tiled") {
    const int ts = define_value(opts_, "TS", 16);
    lx_ = ly_ = std::size_t(ts);
    tsm_ = tsn_ = ts;
    if (2 * std::size_t(ts) * ts * sizeof(float) > e.local_mem()) why_ = "tiles exceed local memory";
  } else if (kernel_ == "gemm_reg") {
    tsm_ = define_value(opts_, "TSM", 64), tsn_ = define_value(opts_, "TSN", 64);
    const int tsk = define_value(opts_, "TSK", 16);
    const int wptm = define_value(opts_, "WPTM", 4), wptn = define_value(opts_, "WPTN", 4);
    why_ = check_reg_config(e, tsm_, tsn_, tsk, wptm, wptn);
    if (why_.empty()) lx_ = std::size_t(tsn_ / wptn), ly_ = std::size_t(tsm_ / wptm);
  } else {
    throw std::invalid_argument("unknown GEMM kernel '" + kernel_ + "'");
  }
  if (why_.empty() && lx_ * ly_ > e.max_work_group())
    why_ = std::to_string(lx_ * ly_) + " work-items > CL_DEVICE_MAX_WORK_GROUP_SIZE (" +
           std::to_string(e.max_work_group()) + ")";
  if (!why_.empty()) return;

  built_ = &e.build(kFile, opts_);
  k_ = cl::Kernel(built_->program, kernel_.c_str());
}

double Gemm::run(int N, const cl::Buffer& A, const cl::Buffer& B, cl::Buffer& C) {
  if (!why_.empty()) throw std::logic_error(kernel_ + " is not runnable: " + why_);
#ifdef CLK_HAVE_CLBLAST
  if (kernel_ == "clblast") return clblast_gemm(env_, N, A, B, C);
#endif
  k_.setArg(0, N);
  k_.setArg(1, A);
  k_.setArg(2, B);
  k_.setArg(3, C);
  // Global size: one work-group per tile of C, rounded up so partial tiles at the edge are covered
  // (OpenCL 1.2 requires a multiple of the work-group size; the kernels bounds-check).
  const std::size_t groupsX = (std::size_t(N) + tsn_ - 1) / tsn_;
  const std::size_t groupsY = (std::size_t(N) + tsm_ - 1) / tsm_;
  const cl::NDRange global(groupsX * lx_, groupsY * ly_), local(lx_, ly_);
  return launch_ms(env_, k_, global, local);
}

std::string Gemm::local_str() const {
  if (kernel_ == "clblast") return {};
  return std::to_string(lx_) + "x" + std::to_string(ly_);
}

PtxasInfo Gemm::ptxas() const { return built_ ? ptxas_info(built_->log, kernel_) : PtxasInfo{}; }

std::string Gemm::binary() const { return built_ ? program_binary(built_->program) : std::string(); }

double gemm_mnk(Env& e, const std::string& opts, int M, int N, int K, const cl::Buffer& A,
                const cl::Buffer& B, cl::Buffer& C) {
  const int tsm = define_value(opts, "TSM", 64), tsn = define_value(opts, "TSN", 64);
  const int tsk = define_value(opts, "TSK", 16);
  const int wptm = define_value(opts, "WPTM", 4), wptn = define_value(opts, "WPTN", 4);
  if (const std::string why = check_reg_config(e, tsm, tsn, tsk, wptm, wptn); !why.empty())
    throw std::invalid_argument("gemm_mnk: " + why);
  cl::Kernel k(e.build(kFile, opts).program, "gemm_mnk");
  k.setArg(0, M);
  k.setArg(1, N);
  k.setArg(2, K);
  k.setArg(3, A);
  k.setArg(4, B);
  k.setArg(5, C);
  const std::size_t lx = std::size_t(tsn / wptn), ly = std::size_t(tsm / wptm);
  const cl::NDRange global((std::size_t(N) + tsn - 1) / tsn * lx, (std::size_t(M) + tsm - 1) / tsm * ly);
  return launch_ms(e, k, global, cl::NDRange(lx, ly));
}

double transpose(Env& e, int R, int C, const cl::Buffer& in, cl::Buffer& out) {
  constexpr std::size_t tt = 16;
  cl::Kernel k(e.build(kFile, "").program, "transpose");
  k.setArg(0, R);
  k.setArg(1, C);
  k.setArg(2, in);
  k.setArg(3, out);
  return launch_ms(e, k, cl::NDRange(round_up(std::size_t(C), tt), round_up(std::size_t(R), tt)),
                   cl::NDRange(tt, tt));
}

double scale(Env& e, int n, float s, cl::Buffer& x) {
  constexpr std::size_t wg = 256;
  cl::Kernel k(e.build(kFile, "").program, "scale");
  k.setArg(0, n);
  k.setArg(1, s);
  k.setArg(2, x);
  return launch_ms(e, k, cl::NDRange(round_up(std::size_t(n), wg)), cl::NDRange(wg));
}

}  // namespace clk
