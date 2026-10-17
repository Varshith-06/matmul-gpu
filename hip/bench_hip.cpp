// HIP benchmark harness for kernel 3, with the README's method: every configuration is checked
// against the double-precision CPU reference before it is timed; one warm-up launch, then --reps
// timed launches (hipEvent pairs), median reported; host<->device copies timed separately.
//
//   bench_hip --info | --list
//   bench_hip [--config TSM,TSN,TSK,WPTM,WPTN[,contig]]... [--grid] [--all] [--n N]...
//             [--reps R] [--csv FILE] [--no-check] [--tol X] [--seed S]
//   bench_hip --rocblas --n N... [--csv FILE]            library ceiling (AMD only)
//   bench_hip --bandwidth [--csv FILE]                   copy kernel, GB/s at several sizes
//   bench_hip --fma [--csv FILE]                         FMA throughput kernel
//   bench_hip --clock [--config ...] [--n N]             shader clock while GEMM runs
//
// Exit codes: 0 ok, 1 failed check or HIP error, 2 bad arguments, 3 nothing runnable.

#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <memory>
#include <random>
#include <string>
#include <thread>
#include <vector>

#include "clkernels/host_matrix.hpp"
#include "clkernels/reference.hpp"
#include "gemm_hip.hpp"

#ifdef CLK_HAVE_ROCBLAS
#include <rocblas/rocblas.h>
#endif

namespace {

using clk::hip::Config;

struct Options {
  int device = 0;
  std::vector<Config> configs;
  bool grid = false, all = false;
  std::vector<int> n;
  unsigned reps = 20;
  std::string csv;
  unsigned seed = 42;
  double tol = 1e-4;
  bool check = true;
  bool info = false, list = false, rocblas = false, bandwidth = false, fma = false, clock = false;
};

[[noreturn]] void usage_error(const std::string& msg) {
  std::fprintf(stderr, "bench_hip: %s (see the header of hip/bench_hip.cpp)\n", msg.c_str());
  std::exit(2);
}

Options parse(int argc, char** argv) {
  Options o;
  for (int i = 1; i < argc; ++i) {
    const std::string a = argv[i];
    auto next = [&]() -> std::string {
      if (i + 1 >= argc) usage_error("missing value for " + a);
      return argv[++i];
    };
    try {
      if (a == "--device") o.device = std::stoi(next());
      else if (a == "--config") o.configs.push_back(clk::hip::parse_config(next()));
      else if (a == "--grid") o.grid = true;
      else if (a == "--all") o.all = true;
      else if (a == "--n") o.n.push_back(std::stoi(next()));
      else if (a == "--reps") o.reps = unsigned(std::stoul(next()));
      else if (a == "--csv") o.csv = next();
      else if (a == "--seed") o.seed = unsigned(std::stoul(next()));
      else if (a == "--tol") o.tol = std::stod(next());
      else if (a == "--no-check") o.check = false;
      else if (a == "--info") o.info = true;
      else if (a == "--list") o.list = true;
      else if (a == "--rocblas") o.rocblas = true;
      else if (a == "--bandwidth") o.bandwidth = true;
      else if (a == "--fma") o.fma = true;
      else if (a == "--clock") o.clock = true;
      else usage_error("unknown flag " + a);
    } catch (const std::invalid_argument& e) {
      usage_error(e.what());
    }
  }
  if (o.n.empty()) o.n = {1024};
  if (o.reps == 0) usage_error("--reps must be positive");
  return o;
}

double median(std::vector<double> v) {
  std::sort(v.begin(), v.end());
  const std::size_t m = v.size() / 2;
  return v.size() % 2 ? v[m] : 0.5 * (v[m - 1] + v[m]);
}

const char* arch_name(const hipDeviceProp_t& p) {
#ifdef __HIP_PLATFORM_AMD__
  return p.gcnArchName;
#else
  (void)p;
  return "nvidia";
#endif
}

const char* backend() {
#ifdef __HIP_PLATFORM_AMD__
  return "hip-amd";
#else
  return "hip-nvidia";
#endif
}

// Appends one line to the CSV (header first if the file is new) and echoes it to stdout.
void emit(const Options& o, const std::string& header, const std::string& line) {
  std::printf("%s\n", line.c_str());
  if (o.csv.empty()) return;
  bool fresh = true;
  {
    std::ifstream probe(o.csv);
    fresh = !probe.good() || probe.peek() == std::ifstream::traits_type::eof();
  }
  std::ofstream out(o.csv, std::ios::app);
  if (fresh) out << header << "\n";
  out << line << "\n";
}

std::string device_prefix(const hipDeviceProp_t& p) {
  std::string name = p.name;
  std::replace(name.begin(), name.end(), ',', ' ');
  return name + "," + arch_name(p) + "," + backend() + "," + std::to_string(p.warpSize) + "," +
         std::to_string(p.multiProcessorCount);
}

struct Buffer {
  float* p = nullptr;
  std::size_t bytes = 0;
  explicit Buffer(std::size_t b) : bytes(b) { CLK_HIP_CHECK(hipMalloc(&p, b)); }
  ~Buffer() { (void)hipFree(p); }
  Buffer(const Buffer&) = delete;
  Buffer& operator=(const Buffer&) = delete;
};

float copy_ms(void* dst, const void* src, std::size_t bytes, hipMemcpyKind kind) {
  hipEvent_t t0, t1;
  CLK_HIP_CHECK(hipEventCreate(&t0));
  CLK_HIP_CHECK(hipEventCreate(&t1));
  CLK_HIP_CHECK(hipEventRecord(t0, nullptr));
  CLK_HIP_CHECK(hipMemcpyAsync(dst, src, bytes, kind, nullptr));
  CLK_HIP_CHECK(hipEventRecord(t1, nullptr));
  CLK_HIP_CHECK(hipEventSynchronize(t1));
  float ms = 0.0f;
  CLK_HIP_CHECK(hipEventElapsedTime(&ms, t0, t1));
  CLK_HIP_CHECK(hipEventDestroy(t0));
  CLK_HIP_CHECK(hipEventDestroy(t1));
  return ms;
}

// --- kernel 3 -------------------------------------------------------------------------------------

const char* const kGemmHeader =
    "gpu,arch,backend,warp_size,cus,kernel,config,tsm,tsn,tsk,wptm,wptn,contig,threads,n,reps,"
    "median_ms,min_ms,gflops,h2d_ms,d2h_ms,max_rel_err,registers,scratch_bytes,lds_bytes,"
    "blocks_per_cu";

struct Problem {
  int n;
  clk::HostMatrix A, B, C;
  Buffer dA, dB, dC;
  double h2d = 0, d2h = 0;
  Problem(int n_, unsigned seed)
      : n(n_), A(std::size_t(n_)), B(std::size_t(n_)), C(std::size_t(n_)),
        dA(A.bytes()), dB(B.bytes()), dC(C.bytes()) {
    std::mt19937 rng(seed);
    A.fill_random(rng);
    B.fill_random(rng);
    std::vector<double> t;  // median of 3, as in bench/main.cpp
    for (int i = 0; i < 3; ++i)
      t.push_back(copy_ms(dA.p, A.data(), A.bytes(), hipMemcpyHostToDevice) +
                  copy_ms(dB.p, B.data(), B.bytes(), hipMemcpyHostToDevice));
    h2d = median(t);
  }
  double read_back() {
    std::vector<double> t;
    for (int i = 0; i < 3; ++i) t.push_back(copy_ms(C.data(), dC.p, C.bytes(), hipMemcpyDeviceToHost));
    return d2h = median(t);
  }
};

// 0: timed and emitted; 1: failed the check (nothing emitted); 3: not runnable here.
int run_gemm(const Options& o, const hipDeviceProp_t& prop, const Config& c, Problem& pr) {
  clk::hip::Gemm g(prop, c);
  if (!g.invalid().empty()) {
    std::fprintf(stderr, "bench_hip: %s is not runnable here: %s\n", c.str().c_str(),
                 g.invalid().c_str());
    return 3;
  }
  CLK_HIP_CHECK(hipMemset(pr.dC.p, 0xff, pr.dC.bytes));
  g.run(pr.n, pr.dA.p, pr.dB.p, pr.dC.p);  // warm-up; its result is the one checked
  pr.read_back();
  double err = NAN;
  if (o.check) {
    err = clk::gemm_check(pr.A, pr.B, pr.C);
    if (!(err <= o.tol)) {
      std::fprintf(stderr, "bench_hip: %s N=%d FAILED the check: max_rel_err %.3g > %.3g\n",
                   c.str().c_str(), pr.n, err, o.tol);
      return 1;
    }
  }
  std::vector<double> t;
  for (unsigned r = 0; r < o.reps; ++r) t.push_back(g.run(pr.n, pr.dA.p, pr.dB.p, pr.dC.p));
  const double med = median(t), best = *std::min_element(t.begin(), t.end());
  const double nn = double(pr.n);
  const clk::hip::KernelInfo k = g.info();
  char line[1024];
  std::snprintf(line, sizeof line,
                "%s,gemm_reg,%s,%d,%d,%d,%d,%d,%d,%d,%d,%u,%.4f,%.4f,%.1f,%.4f,%.4f,%.3g,%d,%zu,%zu,%d",
                device_prefix(prop).c_str(), c.str().c_str(), c.tsm, c.tsn, c.tsk, c.wptm, c.wptn,
                int(c.contig), c.threads(), pr.n, o.reps, med, best,
                2.0 * nn * nn * nn / (med * 1e-3) / 1e9, pr.h2d, pr.d2h, err, k.registers,
                k.scratch_bytes, k.lds_bytes, k.blocks_per_cu);
  emit(o, kGemmHeader, line);
  return 0;
}

// --- rocBLAS --------------------------------------------------------------------------------------

int run_rocblas(const Options& o, const hipDeviceProp_t& prop) {
#ifdef CLK_HAVE_ROCBLAS
  rocblas_handle h;
  if (rocblas_create_handle(&h) != rocblas_status_success) throw std::runtime_error("rocblas_create_handle");
  std::size_t vlen = 0;
  rocblas_get_version_string_size(&vlen);
  std::string version(vlen, ' ');
  rocblas_get_version_string(version.data(), vlen);
  version = "rocBLAS " + std::string(version.c_str());
  for (int n : o.n) {
    Problem pr(n, o.seed);
    const float alpha = 1.0f, beta = 0.0f;
    hipEvent_t t0, t1;
    CLK_HIP_CHECK(hipEventCreate(&t0));
    CLK_HIP_CHECK(hipEventCreate(&t1));
    // Row-major C = A B is column-major C^T = B^T A^T: pass B first, no transposes.
    auto call = [&]() -> float {
      CLK_HIP_CHECK(hipEventRecord(t0, nullptr));
      const rocblas_status s = rocblas_sgemm(h, rocblas_operation_none, rocblas_operation_none, n, n,
                                             n, &alpha, pr.dB.p, n, pr.dA.p, n, &beta, pr.dC.p, n);
      if (s != rocblas_status_success)
        throw std::runtime_error(std::string("rocblas_sgemm: ") + rocblas_status_to_string(s));
      CLK_HIP_CHECK(hipEventRecord(t1, nullptr));
      CLK_HIP_CHECK(hipEventSynchronize(t1));
      float ms = 0;
      CLK_HIP_CHECK(hipEventElapsedTime(&ms, t0, t1));
      return ms;
    };
    CLK_HIP_CHECK(hipMemset(pr.dC.p, 0xff, pr.dC.bytes));
    call();  // warm-up: loads the library's kernels
    pr.read_back();
    const double err = clk::gemm_check(pr.A, pr.B, pr.C);
    if (!(err <= o.tol)) {
      std::fprintf(stderr, "bench_hip: rocblas_sgemm N=%d FAILED the check: %.3g\n", n, err);
      return 1;
    }
    std::vector<double> t;
    for (unsigned r = 0; r < o.reps; ++r) t.push_back(call());
    const double med = median(t), nn = double(n);
    char line[1024];
    std::snprintf(line, sizeof line, "%s,rocblas_sgemm,%s,0,0,0,0,0,0,0,%d,%u,%.4f,%.4f,%.1f,%.4f,%.4f,%.3g,,,,",
                  device_prefix(prop).c_str(), version.c_str(), n, o.reps, med, *std::min_element(t.begin(), t.end()),
                  2.0 * nn * nn * nn / (med * 1e-3) / 1e9, pr.h2d, pr.d2h, err);
    emit(o, kGemmHeader, line);
    CLK_HIP_CHECK(hipEventDestroy(t0));
    CLK_HIP_CHECK(hipEventDestroy(t1));
  }
  rocblas_destroy_handle(h);
  return 0;
#else
  (void)o, (void)prop;
  std::fprintf(stderr, "bench_hip: built without rocBLAS\n");
  return 3;
#endif
}

// --- memory bandwidth -------------------------------------------------------------------------------

// y = x, four floats per thread. Counts 8 bytes per float moved (one read, one write).
__global__ void copy_kernel(const float4* __restrict__ x, float4* __restrict__ y, std::size_t n4) {
  const std::size_t i = std::size_t(blockIdx.x) * blockDim.x + threadIdx.x;
  if (i < n4) y[i] = x[i];
}

int run_bandwidth(const Options& o, const hipDeviceProp_t& prop) {
  const char* header = "gpu,arch,backend,warp_size,cus,kernel,mbytes,reps,median_ms,min_ms,gbps";
  for (std::size_t mb : {4, 16, 64, 256, 1024}) {
    const std::size_t bytes = mb << 20, n4 = bytes / sizeof(float4);
    Buffer x(bytes), y(bytes);
    CLK_HIP_CHECK(hipMemset(x.p, 0, bytes));
    const unsigned block = 256;
    const unsigned grid = unsigned((n4 + block - 1) / block);
    hipEvent_t t0, t1;
    CLK_HIP_CHECK(hipEventCreate(&t0));
    CLK_HIP_CHECK(hipEventCreate(&t1));
    std::vector<double> t;
    for (unsigned r = 0; r <= o.reps; ++r) {  // r = 0 is the warm-up
      CLK_HIP_CHECK(hipEventRecord(t0, nullptr));
      copy_kernel<<<grid, block>>>(reinterpret_cast<const float4*>(x.p), reinterpret_cast<float4*>(y.p), n4);
      CLK_HIP_CHECK(hipGetLastError());
      CLK_HIP_CHECK(hipEventRecord(t1, nullptr));
      CLK_HIP_CHECK(hipEventSynchronize(t1));
      float ms = 0;
      CLK_HIP_CHECK(hipEventElapsedTime(&ms, t0, t1));
      if (r) t.push_back(ms);
    }
    const double med = median(t);
    char line[512];
    std::snprintf(line, sizeof line, "%s,copy,%zu,%u,%.4f,%.4f,%.1f", device_prefix(prop).c_str(), mb,
                  o.reps, med, *std::min_element(t.begin(), t.end()), 2.0 * double(bytes) / (med * 1e-3) / 1e9);
    emit(o, header, line);
    CLK_HIP_CHECK(hipEventDestroy(t0));
    CLK_HIP_CHECK(hipEventDestroy(t1));
  }
  return 0;
}

// --- FMA throughput -------------------------------------------------------------------------------

// Eight independent FMA chains per thread, enough blocks to fill every CU. Measures how many FP32
// FLOPs per second the device sustains on code with no memory traffic, which shows whether the
// compiler and hardware dual-issue (more than 2 FLOPs per lane per clock).
constexpr int kFmaIters = 4096;
__global__ void fma_kernel(float* out, float a, float b) {
  float x0 = threadIdx.x, x1 = x0 + 1, x2 = x0 + 2, x3 = x0 + 3, x4 = x0 + 4, x5 = x0 + 5,
        x6 = x0 + 6, x7 = x0 + 7;
  for (int i = 0; i < kFmaIters; ++i) {
    x0 = fmaf(x0, a, b), x1 = fmaf(x1, a, b), x2 = fmaf(x2, a, b), x3 = fmaf(x3, a, b);
    x4 = fmaf(x4, a, b), x5 = fmaf(x5, a, b), x6 = fmaf(x6, a, b), x7 = fmaf(x7, a, b);
  }
  out[std::size_t(blockIdx.x) * blockDim.x + threadIdx.x] = x0 + x1 + x2 + x3 + x4 + x5 + x6 + x7;
}

int run_fma(const Options& o, const hipDeviceProp_t& prop) {
  const char* header = "gpu,arch,backend,warp_size,cus,kernel,block,blocks,reps,median_ms,min_ms,gflops";
  for (unsigned block : {256u, 1024u}) {
    const unsigned blocks = unsigned(prop.multiProcessorCount) * 64;
    Buffer out(std::size_t(blocks) * block * sizeof(float));
    hipEvent_t t0, t1;
    CLK_HIP_CHECK(hipEventCreate(&t0));
    CLK_HIP_CHECK(hipEventCreate(&t1));
    std::vector<double> t;
    for (unsigned r = 0; r <= o.reps; ++r) {
      CLK_HIP_CHECK(hipEventRecord(t0, nullptr));
      fma_kernel<<<blocks, block>>>(out.p, 0.999f, 0.001f);
      CLK_HIP_CHECK(hipGetLastError());
      CLK_HIP_CHECK(hipEventRecord(t1, nullptr));
      CLK_HIP_CHECK(hipEventSynchronize(t1));
      float ms = 0;
      CLK_HIP_CHECK(hipEventElapsedTime(&ms, t0, t1));
      if (r) t.push_back(ms);
    }
    const double med = median(t);
    const double flops = 2.0 * 8 * kFmaIters * double(blocks) * block;
    char line[512];
    std::snprintf(line, sizeof line, "%s,fma,%u,%u,%u,%.4f,%.4f,%.1f", device_prefix(prop).c_str(), block,
                  blocks, o.reps, med, *std::min_element(t.begin(), t.end()), flops / (med * 1e-3) / 1e9);
    emit(o, header, line);
    CLK_HIP_CHECK(hipEventDestroy(t0));
    CLK_HIP_CHECK(hipEventDestroy(t1));
  }
  return 0;
}

// --- shader clock ---------------------------------------------------------------------------------

// One thread reads the shader-cycle counter and the constant-rate wall clock, spins for `ticks`
// wall-clock ticks, and reads both again. Cycles / seconds = the clock of the CU it ran on.
// RDNA 3's cycle counter (SHADER_CYCLES) is 20 bits wide, so the window stays well below
// 2^20 cycles and the difference is taken modulo 2^20. On NVIDIA (the correctness-check backend)
// the wall clock is %globaltimer in nanoseconds, which lets the method be checked against
// nvidia-smi.
__device__ unsigned long long wall_ticks() {
#ifdef __HIP_PLATFORM_AMD__
  return wall_clock64();
#else
  unsigned long long t;
  asm volatile("mov.u64 %0, %%globaltimer;" : "=l"(t));
  return t;
#endif
}

__global__ void clock_probe(unsigned long long* out, unsigned long long ticks) {
  const unsigned long long w0 = wall_ticks();
  const unsigned long long c0 = clock64();
  unsigned long long w1 = w0;
  while (w1 - w0 < ticks) w1 = wall_ticks();
  const unsigned long long c1 = clock64();
  out[0] = (c1 - c0) & 0xFFFFFull;
  out[1] = w1 - w0;
}

int run_clock(const Options& o, const hipDeviceProp_t& prop) {
  int wall_khz = 1000000;  // %globaltimer: 1 GHz
#ifdef __HIP_PLATFORM_AMD__
  CLK_HIP_CHECK(hipDeviceGetAttribute(&wall_khz, hipDeviceAttributeWallClockRate, o.device));
#endif
  if (wall_khz <= 0) throw std::runtime_error("device reports no wall clock rate");
  const unsigned long long ticks = (unsigned long long)wall_khz * 100 / 1000;  // 100 us
  unsigned long long* d = nullptr;
  CLK_HIP_CHECK(hipMalloc(&d, 2 * sizeof(unsigned long long)));
  hipStream_t probe, load;
  CLK_HIP_CHECK(hipStreamCreateWithFlags(&probe, hipStreamNonBlocking));
  CLK_HIP_CHECK(hipStreamCreateWithFlags(&load, hipStreamNonBlocking));

  // The load: the given GEMM configuration, launched back to back for about two seconds, while
  // the probe samples the clock on another stream. With no --config, the probe runs on an idle GPU.
  std::unique_ptr<Problem> pr;
  std::unique_ptr<clk::hip::Gemm> g;
  if (!o.configs.empty()) {
    g = std::make_unique<clk::hip::Gemm>(prop, o.configs[0]);
    if (!g->invalid().empty()) throw std::runtime_error(g->invalid());
    pr = std::make_unique<Problem>(o.n[0], o.seed);
  }
  const char* header = "gpu,arch,backend,warp_size,cus,load,n,sample,t_s,mhz";
  const auto start = std::chrono::steady_clock::now();
  int sample = 0;
  while (std::chrono::steady_clock::now() - start < std::chrono::seconds(3)) {
    if (g)  // keep the load stream busy while the probe runs
      for (int i = 0; i < 4; ++i) g->launch(pr->n, pr->dA.p, pr->dB.p, pr->dC.p, load);
    clock_probe<<<1, 1, 0, probe>>>(d, ticks);
    CLK_HIP_CHECK(hipGetLastError());
    unsigned long long h[2];
    CLK_HIP_CHECK(hipMemcpyAsync(h, d, sizeof h, hipMemcpyDeviceToHost, probe));
    CLK_HIP_CHECK(hipStreamSynchronize(probe));
    const double secs = double(h[1]) / (double(wall_khz) * 1e3);
    const double t = std::chrono::duration<double>(std::chrono::steady_clock::now() - start).count();
    char line[512];
    std::snprintf(line, sizeof line, "%s,%s,%d,%d,%.3f,%.0f", device_prefix(prop).c_str(),
                  g ? ("gemm_reg " + o.configs[0].str()).c_str() : "idle", g ? pr->n : 0, sample++, t,
                  double(h[0]) / secs / 1e6);
    emit(o, header, line);
    CLK_HIP_CHECK(hipStreamSynchronize(load));
  }
  CLK_HIP_CHECK(hipDeviceSynchronize());
  CLK_HIP_CHECK(hipFree(d));
  CLK_HIP_CHECK(hipStreamDestroy(probe));
  CLK_HIP_CHECK(hipStreamDestroy(load));
  return 0;
}

void print_info(const Options& o, const hipDeviceProp_t& p) {
  int runtime = 0, driver = 0, wall_khz = 0;
  CLK_HIP_CHECK(hipRuntimeGetVersion(&runtime));
  CLK_HIP_CHECK(hipDriverGetVersion(&driver));
#ifdef __HIP_PLATFORM_AMD__
  CLK_HIP_CHECK(hipDeviceGetAttribute(&wall_khz, hipDeviceAttributeWallClockRate, o.device));
#endif
  std::printf("name                %s\n", p.name);
  std::printf("arch                %s\n", arch_name(p));
  std::printf("backend             %s\n", backend());
  std::printf("runtime / driver    %d / %d\n", runtime, driver);
  std::printf("multiProcessorCount %d\n", p.multiProcessorCount);
  std::printf("warpSize            %d\n", p.warpSize);
  std::printf("clockRate           %d kHz (reported maximum)\n", p.clockRate);
  std::printf("wall clock rate     %d kHz\n", wall_khz);
  std::printf("maxThreadsPerBlock  %d\n", p.maxThreadsPerBlock);
  std::printf("sharedMemPerBlock   %zu\n", p.sharedMemPerBlock);
  std::printf("regsPerBlock        %d\n", p.regsPerBlock);
  std::printf("maxThreadsPerMP     %d\n", p.maxThreadsPerMultiProcessor);
  std::printf("totalGlobalMem      %zu MB\n", p.totalGlobalMem >> 20);
  std::printf("memoryClockRate     %d kHz\n", p.memoryClockRate);
  std::printf("memoryBusWidth      %d bits\n", p.memoryBusWidth);
  std::printf("l2CacheSize         %d B\n", p.l2CacheSize);
  std::printf("integrated          %d\n", p.integrated);
}

}  // namespace

int main(int argc, char** argv) {
  const Options o = parse(argc, argv);
  try {
    CLK_HIP_CHECK(hipSetDevice(o.device));
    hipDeviceProp_t prop;
    CLK_HIP_CHECK(hipGetDeviceProperties(&prop, o.device));
    if (o.info) return print_info(o, prop), 0;
    if (o.list) {
      for (const Config& c : clk::hip::compiled_configs()) {
        const std::string why = clk::hip::check_config(prop, c);
        std::printf("%-28s %s\n", c.str().c_str(), why.empty() ? "ok" : why.c_str());
      }
      return 0;
    }
    if (o.rocblas) return run_rocblas(o, prop);
    if (o.bandwidth) return run_bandwidth(o, prop);
    if (o.fma) return run_fma(o, prop);
    if (o.clock) return run_clock(o, prop);

    std::vector<Config> configs = o.configs;
    for (const Config& c : clk::hip::compiled_configs()) {
      const bool in_grid = c.tsm == c.tsn && c.wptm == c.wptn && c.wptm >= 2 && !c.contig &&
                           (c.tsm == 32 || c.tsm == 64 || c.tsm == 128) &&
                           (c.tsk == 8 || c.tsk == 16 || c.tsk == 32);
      if (o.all || (o.grid && in_grid)) configs.push_back(c);
    }
    if (configs.empty()) usage_error("no configuration given (--config, --grid or --all)");

    int ran = 0, failed = 0;
    for (int n : o.n) {
      Problem pr(n, o.seed);
      for (const Config& c : configs) {
        const int rc = run_gemm(o, prop, c, pr);
        ran += rc == 0;
        failed += rc == 1;
      }
    }
    if (failed) return 1;
    return ran ? 0 : 3;
  } catch (const std::exception& e) {
    std::fprintf(stderr, "bench_hip: %s\n", e.what());
    return 1;
  }
}
