// Host side of the HIP port: configuration rules, the table of compiled configurations, launch,
// and what the compiler and runtime report about each kernel.

#pragma once

#include <hip/hip_runtime.h>

#include <stdexcept>
#include <string>
#include <vector>

namespace clk::hip {

#define CLK_HIP_CHECK(expr)                                                                \
  do {                                                                                    \
    const hipError_t err_ = (expr);                                                       \
    if (err_ != hipSuccess)                                                               \
      throw std::runtime_error(std::string(#expr) + ": " + hipGetErrorString(err_));      \
  } while (0)

struct Config {
  int tsm = 64, tsn = 64, tsk = 16, wptm = 4, wptn = 4;
  bool contig = false;
  int threads() const { return (tsm / wptm) * (tsn / wptn); }
  std::string str() const;  // "64x64 k16 4x4" (+ " contig")
  bool operator<(const Config& o) const;
};

// Parses "TSM,TSN,TSK,WPTM,WPTN" with an optional ",contig".
Config parse_config(const std::string& s);

// The rules the OpenCL host enforces in check_reg_config(), with this device's limits: WPT divides
// the tile, every thread loads the same number of A and B elements, the block fits
// maxThreadsPerBlock, and both tiles fit sharedMemPerBlock. Empty string: valid.
std::string check_config(const hipDeviceProp_t& prop, const Config& c);

// Every configuration compiled into this binary (the tuning grid plus the test configurations).
std::vector<Config> compiled_configs();

// What the compiler produced for one configuration, from hipFuncGetAttributes and the occupancy API.
struct KernelInfo {
  int registers = 0;          // numRegs: VGPRs on AMD, registers per thread on NVIDIA
  std::size_t lds_bytes = 0;  // static __shared__ use
  std::size_t scratch_bytes = 0;  // private memory per thread; nonzero means spills
  int max_threads = 0;        // the compiled kernel's block-size limit
  int blocks_per_cu = 0;      // resident blocks per CU (AMD) or SM (NVIDIA) at this block size
};

class Gemm {
 public:
  Gemm(const hipDeviceProp_t& prop, const Config& c);
  const std::string& invalid() const { return why_; }  // why it can't run here; empty if it can
  const Config& config() const { return c_; }
  KernelInfo info() const;
  dim3 block() const;
  dim3 grid(int N) const;
  // Launches C = A * B on `stream` and returns the kernel time in ms from a pair of hipEvents.
  float run(int N, const float* A, const float* B, float* C, hipStream_t stream = nullptr) const;
  // Enqueues the kernel without timing or waiting.
  void launch(int N, const float* A, const float* B, float* C, hipStream_t stream) const;

 private:
  Config c_;
  std::string why_;
  const void* fn_ = nullptr;
  void (*launch_)(dim3, dim3, hipStream_t, int, const float*, const float*, float*) = nullptr;
};

}  // namespace clk::hip
