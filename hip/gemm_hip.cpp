#include "gemm_hip.hpp"

#include <map>
#include <sstream>
#include <tuple>

#include "gemm_reg.hpp"

namespace clk::hip {

std::string Config::str() const {
  std::string s = std::to_string(tsm) + "x" + std::to_string(tsn) + " k" + std::to_string(tsk) +
                  " " + std::to_string(wptm) + "x" + std::to_string(wptn);
  return contig ? s + " contig" : s;
}

bool Config::operator<(const Config& o) const {
  return std::tie(tsm, tsn, tsk, wptm, wptn, contig) <
         std::tie(o.tsm, o.tsn, o.tsk, o.wptm, o.wptn, o.contig);
}

Config parse_config(const std::string& s) {
  Config c;
  std::stringstream in(s);
  std::string field;
  std::vector<std::string> f;
  while (std::getline(in, field, ',')) f.push_back(field);
  if (f.size() < 5 || f.size() > 6 || (f.size() == 6 && f[5] != "contig"))
    throw std::invalid_argument("config must be TSM,TSN,TSK,WPTM,WPTN[,contig]: " + s);
  c.tsm = std::stoi(f[0]), c.tsn = std::stoi(f[1]), c.tsk = std::stoi(f[2]);
  c.wptm = std::stoi(f[3]), c.wptn = std::stoi(f[4]);
  c.contig = f.size() == 6;
  return c;
}

std::string check_config(const hipDeviceProp_t& prop, const Config& c) {
  if (c.tsm <= 0 || c.tsn <= 0 || c.tsk <= 0 || c.wptm <= 0 || c.wptn <= 0)
    return "sizes must be positive";
  if (c.tsm % c.wptm) return "TSM % WPTM != 0";
  if (c.tsn % c.wptn) return "TSN % WPTN != 0";
  const long nwi = long(c.tsm / c.wptm) * (c.tsn / c.wptn);
  if ((long(c.tsm) * c.tsk) % nwi) return "(TSM * TSK) % threads != 0";
  if ((long(c.tsk) * c.tsn) % nwi) return "(TSK * TSN) % threads != 0";
  if (nwi > prop.maxThreadsPerBlock)
    return std::to_string(nwi) + " threads > maxThreadsPerBlock (" +
           std::to_string(prop.maxThreadsPerBlock) + ")";
  const std::size_t lds = (std::size_t(c.tsm) * c.tsk + std::size_t(c.tsk) * c.tsn) * sizeof(float);
  if (lds > prop.sharedMemPerBlock)
    return std::to_string(lds) + " B of tiles > sharedMemPerBlock (" +
           std::to_string(prop.sharedMemPerBlock) + ")";
  return {};
}

namespace {

struct Entry {
  const void* fn;
  void (*launch)(dim3, dim3, hipStream_t, int, const float*, const float*, float*);
};

template <int TSM, int TSN, int TSK, int WPTM, int WPTN, bool CONTIG>
void launch(dim3 grid, dim3 block, hipStream_t s, int N, const float* A, const float* B, float* C) {
  gemm_reg<TSM, TSN, TSK, WPTM, WPTN, CONTIG><<<grid, block, 0, s>>>(N, A, B, C);
}

// Registers both ownership layouts of one configuration, if it satisfies the divisibility rules.
// Device limits are checked at run time by check_config(), as the OpenCL host does.
template <int TSM, int TSN, int TSK, int WPTM, int WPTN>
void add(std::map<Config, Entry>& t) {
  if constexpr (divisible<TSM, TSN, TSK, WPTM, WPTN>()) {
    t[Config{TSM, TSN, TSK, WPTM, WPTN, false}] = {
        reinterpret_cast<const void*>(&gemm_reg<TSM, TSN, TSK, WPTM, WPTN, false>),
        &launch<TSM, TSN, TSK, WPTM, WPTN, false>};
    t[Config{TSM, TSN, TSK, WPTM, WPTN, true}] = {
        reinterpret_cast<const void*>(&gemm_reg<TSM, TSN, TSK, WPTM, WPTN, true>),
        &launch<TSM, TSN, TSK, WPTM, WPTN, true>};
  }
}

template <int TS, int TSK>
void add_wpt(std::map<Config, Entry>& t) {
  add<TS, TS, TSK, 2, 2>(t);
  add<TS, TS, TSK, 4, 4>(t);
  add<TS, TS, TSK, 8, 8>(t);
}

template <int TS>
void add_tsk(std::map<Config, Entry>& t) {
  add_wpt<TS, 8>(t);
  add_wpt<TS, 16>(t);
  add_wpt<TS, 32>(t);
}

const std::map<Config, Entry>& table() {
  static const std::map<Config, Entry> t = [] {
    std::map<Config, Entry> m;
    // The OpenCL tuning grid (scripts/tune.py): TSM = TSN in {32, 64, 128}, TSK in {8, 16, 32},
    // WPTM = WPTN in {2, 4, 8}.
    add_tsk<32>(m);
    add_tsk<64>(m);
    add_tsk<128>(m);
    // Test configurations outside the grid: WPT = 1 and a rectangular tile.
    add<16, 16, 16, 1, 1>(m);
    add<64, 32, 16, 8, 2>(m);
    // Larger tiles that the RTX 4060 (48 KB, 1,024 threads) or AMD's OpenCL driver (256 work-items)
    // cannot run, kept to probe the 64 KB LDS and 1,024-thread limits on AMD.
    add<128, 128, 32, 4, 4>(m);  // 1,024 threads
#ifdef __HIP_PLATFORM_AMD__  // NVIDIA allows at most 48 KB of static shared memory per block
    add<128, 128, 64, 8, 8>(m);  // exactly 64 KB of tiles
#endif
    return m;
  }();
  return t;
}

}  // namespace

std::vector<Config> compiled_configs() {
  std::vector<Config> v;
  for (const auto& kv : table()) v.push_back(kv.first);
  return v;
}

Gemm::Gemm(const hipDeviceProp_t& prop, const Config& c) : c_(c) {
  why_ = check_config(prop, c);
  if (!why_.empty()) return;
  const auto it = table().find(c);
  if (it == table().end()) {
    why_ = "not compiled into this binary (see table() in hip/gemm_hip.cpp)";
    return;
  }
  fn_ = it->second.fn;
  launch_ = it->second.launch;
}

KernelInfo Gemm::info() const {
  KernelInfo k;
  if (!fn_) return k;
  hipFuncAttributes a{};
  CLK_HIP_CHECK(hipFuncGetAttributes(&a, fn_));
  k.registers = a.numRegs;
  k.lds_bytes = a.sharedSizeBytes;
  k.scratch_bytes = a.localSizeBytes;
  k.max_threads = a.maxThreadsPerBlock;
  CLK_HIP_CHECK(hipOccupancyMaxActiveBlocksPerMultiprocessor(&k.blocks_per_cu, fn_,
                                                             c_.threads(), 0));
  return k;
}

dim3 Gemm::block() const { return dim3(unsigned(c_.tsn / c_.wptn), unsigned(c_.tsm / c_.wptm)); }

dim3 Gemm::grid(int N) const {
  return dim3(unsigned((N + c_.tsn - 1) / c_.tsn), unsigned((N + c_.tsm - 1) / c_.tsm));
}

void Gemm::launch(int N, const float* A, const float* B, float* C, hipStream_t stream) const {
  if (!why_.empty()) throw std::logic_error("gemm_reg " + c_.str() + " is not runnable: " + why_);
  launch_(grid(N), block(), stream, N, A, B, C);
  CLK_HIP_CHECK(hipGetLastError());
}

float Gemm::run(int N, const float* A, const float* B, float* C, hipStream_t stream) const {
  if (!why_.empty()) throw std::logic_error("gemm_reg " + c_.str() + " is not runnable: " + why_);
  hipEvent_t t0, t1;
  CLK_HIP_CHECK(hipEventCreate(&t0));
  CLK_HIP_CHECK(hipEventCreate(&t1));
  CLK_HIP_CHECK(hipEventRecord(t0, stream));
  launch_(grid(N), block(), stream, N, A, B, C);
  CLK_HIP_CHECK(hipGetLastError());
  CLK_HIP_CHECK(hipEventRecord(t1, stream));
  CLK_HIP_CHECK(hipEventSynchronize(t1));
  float ms = 0.0f;
  CLK_HIP_CHECK(hipEventElapsedTime(&ms, t0, t1));
  CLK_HIP_CHECK(hipEventDestroy(t0));
  CLK_HIP_CHECK(hipEventDestroy(t1));
  return ms;
}

}  // namespace clk::hip
