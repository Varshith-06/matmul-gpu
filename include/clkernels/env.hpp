#pragma once

#include <CL/opencl.hpp>

#include <cstddef>
#include <iosfwd>
#include <map>
#include <string>
#include <utility>

namespace clk {

// First device whose CL_DEVICE_NAME contains `want`; an empty string means the first device found.
// Laptops expose an integrated GPU too, so benchmarks always pass a name ("RTX 4060").
cl::Device pick_device(const std::string& want);

// --devices: every platform and device with the properties the README quotes.
void list_devices(std::ostream& out);

// Name of an OpenCL error code, e.g. -54 -> "CL_INVALID_WORK_GROUP_SIZE".
const char* error_name(cl_int code);

// "clEnqueueNDRangeKernel failed: CL_INVALID_WORK_GROUP_SIZE (-54)".
std::string describe(const cl::Error& e);

inline std::size_t round_up(std::size_t x, std::size_t m) { return (x + m - 1) / m * m; }

// Value of -DNAME=V in a build-option string, or `fallback` if NAME is not defined there.
int define_value(const std::string& opts, const std::string& name, int fallback);

struct Built {
  cl::Program program;
  std::string log;  // build log, including ptxas register counts with -cl-nv-verbose on NVIDIA
};

struct Env {
  cl::Device dev;
  cl::Context ctx;
  cl::CommandQueue q;

  explicit Env(const std::string& name);

  std::string device_name() const { return dev.getInfo<CL_DEVICE_NAME>(); }
  std::string driver() const { return dev.getInfo<CL_DRIVER_VERSION>(); }
  bool is_nvidia() const;
  std::size_t max_work_group() const { return dev.getInfo<CL_DEVICE_MAX_WORK_GROUP_SIZE>(); }
  std::size_t local_mem() const {
    return static_cast<std::size_t>(dev.getInfo<CL_DEVICE_LOCAL_MEM_SIZE>());
  }

  // Compiles kernels/<file> with "-cl-std=CL1.2 <opts>", cached by (file, opts) so a sweep does
  // not recompile for every repetition. Prints the build log and rethrows on failure.
  const Built& build(const std::string& file, const std::string& opts);

  // Extra options appended to every build (tests use -Werror; --registers adds -cl-nv-verbose).
  std::string common_opts;

 private:
  std::map<std::pair<std::string, std::string>, Built> cache_;
};

// Kernel execution time from a profiling event, in milliseconds (GPU-side timestamps).
double event_ms(const cl::Event& ev);

// Enqueue, wait, and return the kernel's GPU time in milliseconds.
double launch_ms(Env& e, const cl::Kernel& k, const cl::NDRange& global, const cl::NDRange& local);

// What ptxas reports for one kernel in a -cl-nv-verbose build log; -1 where the log does not say
// (other vendors, or NVIDIA's compute cache served the build: set CUDA_CACHE_DISABLE=1).
struct PtxasInfo {
  int registers = -1;
  int spill_bytes = -1;  // spill stores + loads: registers that overflowed to slow local memory
};
PtxasInfo ptxas_info(const std::string& log, const std::string& kernel);

// The program binary: PTX text on NVIDIA.
std::string program_binary(const cl::Program& p);

}  // namespace clk
