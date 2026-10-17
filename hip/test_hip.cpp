// Correctness tests for the HIP port of kernel 3: the GEMM cases of tests/test_kernels.cpp,
// against the same double-precision CPU reference (src/reference.cpp).
// usage: test_hip [device-index]

#include <cstdio>
#include <random>
#include <string>
#include <vector>

#include "clkernels/host_matrix.hpp"
#include "clkernels/reference.hpp"
#include "gemm_hip.hpp"

namespace {

using clk::hip::Config;

int failures = 0, checks = 0, skipped = 0;

void expect(bool ok, const std::string& what) {
  ++checks;
  if (!ok) {
    ++failures;
    std::printf("FAIL: %s\n", what.c_str());
  }
}

struct DeviceMatrix {
  float* p = nullptr;
  std::size_t bytes = 0;
  explicit DeviceMatrix(const clk::HostMatrix& m) : bytes(m.bytes()) {
    CLK_HIP_CHECK(hipMalloc(&p, bytes));
    CLK_HIP_CHECK(hipMemcpy(p, m.data(), bytes, hipMemcpyHostToDevice));
  }
  ~DeviceMatrix() { (void)hipFree(p); }
  DeviceMatrix(const DeviceMatrix&) = delete;
  DeviceMatrix& operator=(const DeviceMatrix&) = delete;
  void read(clk::HostMatrix& m) const {
    CLK_HIP_CHECK(hipMemcpy(m.data(), p, bytes, hipMemcpyDeviceToHost));
  }
};

// The kernel-3 cases of tests/test_kernels.cpp, plus both layouts of every tuning-grid point
// and the configurations only HIP can run on AMD, so any configuration the sweep times has
// passed here first.
std::vector<Config> test_configs() {
  std::vector<Config> v = {
      {64, 64, 16, 4, 4, false},  {64, 64, 16, 4, 4, true},    {32, 32, 8, 2, 2, false},
      {16, 16, 16, 1, 1, false},  {64, 64, 8, 8, 8, false},    {128, 128, 16, 8, 8, false},
      {64, 32, 16, 8, 2, false},  // rectangular tile
  };
  for (const Config& c : clk::hip::compiled_configs()) {
    bool listed = false;
    for (const Config& t : v) listed |= !(t < c) && !(c < t);
    if (!listed) v.push_back(c);
  }
  return v;
}

void test_gemm(const hipDeviceProp_t& prop) {
  const std::vector<Config> cases = test_configs();
  const std::vector<int> sizes = {1,  2,  3,  15,  16,  17,  31,  32,  33,  63,
                                  64, 65, 100, 127, 128, 129, 1000};
  std::mt19937 rng(1);
  for (int n : sizes) {
    clk::HostMatrix A{std::size_t(n)}, B{std::size_t(n)}, C{std::size_t(n)};
    A.fill_random(rng);
    B.fill_random(rng);
    const auto R = clk::gemm_ref(A, B);
    DeviceMatrix dA(A), dB(B), dC(C);
    for (const Config& c : cases) {
      clk::hip::Gemm g(prop, c);
      if (!g.invalid().empty()) {
        if (n == 1) std::printf("skip: %s (%s)\n", c.str().c_str(), g.invalid().c_str());
        ++skipped;
        continue;
      }
      CLK_HIP_CHECK(hipMemset(dC.p, 0xff, dC.bytes));  // NaN: an unwritten element fails
      g.run(n, dA.p, dB.p, dC.p);
      dC.read(C);
      const double err = clk::max_rel_err(C, R);
      char buf[64];
      std::snprintf(buf, sizeof buf, " err=%.3g", err);
      expect(err <= 1e-4, c.str() + " N=" + std::to_string(n) + buf);
    }
  }

  // Identity: C = I * B must equal B exactly. Tolerances hide swapped indices; this does not.
  for (int n : {17, 64, 129}) {
    clk::HostMatrix I{std::size_t(n)}, B{std::size_t(n)}, C{std::size_t(n)};
    for (std::size_t i = 0; i < I.size(); ++i) I.data()[i] = 0.0f;
    for (int i = 0; i < n; ++i) I(std::size_t(i), std::size_t(i)) = 1.0f;
    B.fill_random(rng);
    DeviceMatrix dI(I), dB(B), dC(C);
    for (const Config& c : cases) {
      clk::hip::Gemm g(prop, c);
      if (!g.invalid().empty()) continue;
      g.run(n, dI.p, dB.p, dC.p);
      dC.read(C);
      bool exact = true;
      for (std::size_t i = 0; i < C.size(); ++i) exact &= C.data()[i] == B.data()[i];
      expect(exact, c.str() + " identity N=" + std::to_string(n));
    }
  }

  // The host must reject configurations that break kernel 3's rules instead of launching them.
  using clk::hip::check_config;
  expect(!check_config(prop, {64, 64, 16, 3, 4}).empty(), "reject TSM % WPTM != 0");
  expect(!check_config(prop, {64, 64, 2, 2, 2}).empty(), "reject (TSM*TSK) % NWI != 0");
  expect(!check_config(prop, {512, 512, 32, 1, 1}).empty(), "reject too many work-items");
  expect(check_config(prop, {64, 64, 16, 4, 4}).empty(), "accept 64/64/16/4/4");
  // The limits come from the device, not from constants: 64 KB of tiles fits a 64 KB device and
  // not a 48 KB one; 1,024 threads fit a 1,024-thread device and not a 256-thread one.
  hipDeviceProp_t p = prop;
  p.maxThreadsPerBlock = 1024;
  p.sharedMemPerBlock = 64 * 1024;
  expect(check_config(p, {128, 128, 64, 8, 8}).empty(), "accept 64 KB of tiles on a 64 KB device");
  p.sharedMemPerBlock = 48 * 1024;
  expect(!check_config(p, {128, 128, 64, 8, 8}).empty(), "reject 64 KB of tiles on a 48 KB device");
  expect(check_config(p, {128, 128, 32, 4, 4}).empty(), "accept 1,024 threads on a 1,024 device");
  p.maxThreadsPerBlock = 256;
  expect(!check_config(p, {128, 128, 32, 4, 4}).empty(), "reject 1,024 threads on a 256 device");
}

}  // namespace

int main(int argc, char** argv) {
  try {
    const int dev = argc > 1 ? std::stoi(argv[1]) : 0;
    CLK_HIP_CHECK(hipSetDevice(dev));
    hipDeviceProp_t prop;
    CLK_HIP_CHECK(hipGetDeviceProperties(&prop, dev));
#ifdef __HIP_PLATFORM_AMD__
    const char* arch = prop.gcnArchName;
#else
    const char* arch = "nvidia";
#endif
    std::printf("device %d: %s (%s), %d CUs, warpSize %d, maxThreadsPerBlock %d, "
                "sharedMemPerBlock %zu\n",
                dev, prop.name, arch, prop.multiProcessorCount, prop.warpSize,
                prop.maxThreadsPerBlock, prop.sharedMemPerBlock);
    test_gemm(prop);
  } catch (const std::exception& e) {
    std::printf("FAIL: %s\n", e.what());
    return 1;
  }
  std::printf("%d checks, %d failed, %d configurations skipped\n", checks, failures, skipped);
  return failures ? 1 : 0;
}
