// CLBlast's row-major SGEMM on the same buffers and queue, as a reference ceiling: an open-source,
// auto-tuned OpenCL BLAS. Built only when CMake finds CLBlast.

// opencl.hpp first: clblast.h redefines CL_TARGET_OPENCL_VERSION to 1.1, which would mark the
// bindings' 2.x calls deprecated.
#include "clkernels/env.hpp"

#include <clblast.h>

#include <chrono>
#include <stdexcept>
#include <string>

namespace clk {

// The event CLBlast returns covers only its last kernel, and for sizes that are not a multiple of
// its tile it also runs pad/copy kernels first. So this one is timed on the host around the whole
// call, from an idle queue to finish(): it includes launch overhead (a few tens of microseconds),
// which only matters at small N.
double clblast_gemm(Env& e, int N, const cl::Buffer& A, const cl::Buffer& B, cl::Buffer& C) {
  cl_command_queue q = e.q();
  cl_event ev = nullptr;
  const auto n = static_cast<std::size_t>(N);
  e.q.finish();
  const auto t0 = std::chrono::steady_clock::now();
  const auto st = clblast::Gemm<float>(clblast::Layout::kRowMajor, clblast::Transpose::kNo,
                                       clblast::Transpose::kNo, n, n, n, 1.0f, A(), 0, n, B(), 0,
                                       n, 0.0f, C(), 0, n, &q, &ev);
  if (st != clblast::StatusCode::kSuccess)
    throw std::runtime_error("CLBlast Gemm failed with status " + std::to_string(int(st)));
  const cl::Event event(ev);  // takes ownership: released when it goes out of scope
  e.q.finish();
  const auto t1 = std::chrono::steady_clock::now();
  return std::chrono::duration<double, std::milli>(t1 - t0).count();
}

}  // namespace clk
