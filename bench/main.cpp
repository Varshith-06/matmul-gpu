// CLI harness: builds one kernel configuration, checks it against a CPU reference, times it with
// GPU-side profiling events, and prints / appends one CSV row per configuration.
//
// Exit codes: 0 ok, 1 failed correctness check or OpenCL error, 2 bad arguments,
// 3 configuration not runnable on this device (sweeps skip these).

#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <iostream>
#include <random>
#include <string>
#include <vector>

#include "clkernels/env.hpp"
#include "clkernels/gemm.hpp"
#include "clkernels/host_matrix.hpp"
#include "clkernels/reference.hpp"
#include "clkernels/softmax.hpp"

namespace {

const char* const kCsvHeader =
    "gpu,driver,kernel,n,rows,cols,opts,local,reps,median_ms,min_ms,gflops,gbps,h2d_ms,d2h_ms,"
    "max_rel_err,registers,spill_bytes";

struct Options {
  std::string device;  // empty: first device found
  std::string kernel = "gemm_naive";
  int n = 1024;
  int rows = 4096, cols = 4096;
  int l = 1024, d = 64;
  std::string opts;
  std::vector<std::size_t> local;
  unsigned reps = 20;
  std::string csv, ptx;
  unsigned seed = 42;
  double tol = 1e-4;
  bool check = true;
  bool registers = false;
  bool buildLog = false;
};

void usage(std::FILE* out) {
  std::fprintf(out,
               "usage: bench --devices | --list\n"
               "       bench [--device NAME] --kernel K [--opts \"-DTS=16 ...\"] [--reps R]\n"
               "             [--csv FILE] [--ptx FILE] [--registers] [--build-log] [--no-check]\n"
               "             [--tol X] [--seed S]\n"
               "  GEMM:      --n N [--local 16x16]          (gemm_naive, gemm_naive_bad,\n"
               "                                             gemm_tiled, gemm_reg, clblast)\n"
               "  row-wise:  --rows R --cols C              (softmax_*, layernorm*)\n"
               "  attention: --l L --d D                    (attn_unfused, attn_fused)\n");
}

[[noreturn]] void fail_arg(const std::string& flag, const char* value) {
  std::fprintf(stderr, "bench: bad value for %s: %s\n", flag.c_str(), value);
  std::exit(2);
}

long to_int(const std::string& flag, const char* s) {
  try {
    std::size_t pos = 0;
    const long v = std::stol(s, &pos);
    if (pos == std::strlen(s) && v > 0) return v;
  } catch (...) {
  }
  fail_arg(flag, s);
}

double to_double(const std::string& flag, const char* s) {
  try {
    std::size_t pos = 0;
    const double v = std::stod(s, &pos);
    if (pos == std::strlen(s) && v > 0) return v;
  } catch (...) {
  }
  fail_arg(flag, s);
}

std::vector<std::size_t> parse_local(const std::string& flag, const char* s) {
  const char* x = std::strchr(s, 'x');
  if (!x) fail_arg(flag, s);
  const std::string a(s, x), b(x + 1);
  return {std::size_t(to_int(flag, a.c_str())), std::size_t(to_int(flag, b.c_str()))};
}

void list_kernels() {
  for (const auto& k : clk::Gemm::names()) std::printf("%s\n", k.c_str());
  for (const auto& k : clk::RowKernel::names()) std::printf("%s\n", k.c_str());
  std::printf("attn_unfused\nattn_fused\n");
}

Options parse(int argc, char** argv) {
  Options o;
  for (int i = 1; i < argc; ++i) {
    const std::string arg = argv[i];
    auto value = [&]() -> const char* {
      if (i + 1 >= argc) {
        std::fprintf(stderr, "bench: %s needs a value\n", arg.c_str());
        std::exit(2);
      }
      return argv[++i];
    };
    if (arg == "--devices") {
      clk::list_devices(std::cout);
      std::exit(0);
    } else if (arg == "--list") {
      list_kernels();
      std::exit(0);
    } else if (arg == "--device") {
      o.device = value();
    } else if (arg == "--kernel") {
      o.kernel = value();
    } else if (arg == "--n") {
      o.n = int(to_int(arg, value()));
    } else if (arg == "--rows") {
      o.rows = int(to_int(arg, value()));
    } else if (arg == "--cols") {
      o.cols = int(to_int(arg, value()));
    } else if (arg == "--l") {
      o.l = int(to_int(arg, value()));
    } else if (arg == "--d") {
      o.d = int(to_int(arg, value()));
    } else if (arg == "--opts") {
      o.opts = value();
    } else if (arg == "--local") {
      o.local = parse_local(arg, value());
    } else if (arg == "--reps") {
      o.reps = unsigned(to_int(arg, value()));
    } else if (arg == "--csv") {
      o.csv = value();
    } else if (arg == "--ptx") {
      o.ptx = value();
    } else if (arg == "--seed") {
      o.seed = unsigned(to_int(arg, value()));
    } else if (arg == "--tol") {
      o.tol = to_double(arg, value());
    } else if (arg == "--no-check") {
      o.check = false;
    } else if (arg == "--registers") {
      o.registers = true;
    } else if (arg == "--build-log") {
      o.buildLog = true;
    } else if (arg == "--help" || arg == "-h") {
      usage(stdout);
      std::exit(0);
    } else {
      std::fprintf(stderr, "bench: unknown option %s\n", arg.c_str());
      usage(stderr);
      std::exit(2);
    }
  }
  return o;
}

double median(std::vector<double> v) {
  std::sort(v.begin(), v.end());
  const std::size_t m = v.size() / 2;
  return v.size() % 2 ? v[m] : 0.5 * (v[m - 1] + v[m]);
}

std::string csv_safe(std::string s) {
  std::replace(s.begin(), s.end(), ',', ' ');
  return s;
}

void append_csv(const std::string& path, const std::string& row) {
  bool needHeader;
  {
    std::ifstream probe(path);
    needHeader = !probe.good() || probe.peek() == std::ifstream::traits_type::eof();
  }
  std::ofstream out(path, std::ios::app);
  if (!out) {
    std::fprintf(stderr, "bench: cannot write %s\n", path.c_str());
    std::exit(1);
  }
  if (needHeader) out << kCsvHeader << '\n';
  out << row << '\n';
}

// One CSV row. Unused numeric columns are blank so one plotting script reads every file.
struct Row {
  std::string kernel, opts, local;
  std::string n, rows, cols;
  unsigned reps = 0;
  double med = 0, best = 0;
  double gflops = NAN, gbps = NAN, h2d = NAN, d2h = NAN, err = NAN;
  clk::PtxasInfo ptxas;
};

std::string num(double v, const char* fmt = "%.6g") {
  if (std::isnan(v)) return {};
  char buf[64];
  std::snprintf(buf, sizeof buf, fmt, v);
  return buf;
}

std::string int_or_blank(int v) { return v >= 0 ? std::to_string(v) : std::string(); }

void emit(const Options& o, clk::Env& env, const Row& r) {
  std::printf("%-22s %-14s %-10s reps=%-3u median=%.4f ms min=%.4f ms", r.kernel.c_str(),
              (!r.n.empty() ? "n=" + r.n : "rows=" + r.rows + " cols=" + r.cols).c_str(),
              r.local.c_str(), r.reps, r.med, r.best);
  if (!std::isnan(r.gflops)) std::printf(" %9.1f GFLOPS", r.gflops);
  if (!std::isnan(r.gbps)) std::printf(" %7.1f GB/s", r.gbps);
  if (!std::isnan(r.err)) std::printf("  err=%.2e", r.err);
  if (r.ptxas.registers >= 0) std::printf("  regs=%d", r.ptxas.registers);
  if (r.ptxas.spill_bytes > 0) std::printf(" spills=%dB", r.ptxas.spill_bytes);
  std::printf("\n");
  if (o.csv.empty()) return;
  const std::string row = csv_safe(env.device_name()) + "," + csv_safe(env.driver()) + "," +
                          r.kernel + "," + r.n + "," + r.rows + "," + r.cols + "," +
                          csv_safe(r.opts) + "," + r.local + "," + std::to_string(r.reps) + "," +
                          num(r.med, "%.6f") + "," + num(r.best, "%.6f") + "," +
                          num(r.gflops, "%.2f") + "," + num(r.gbps, "%.2f") + "," +
                          num(r.h2d, "%.4f") + "," + num(r.d2h, "%.4f") + "," +
                          num(r.err, "%.3e") + "," +
                          int_or_blank(r.ptxas.registers) + "," + int_or_blank(r.ptxas.spill_bytes);
  append_csv(o.csv, row);
}

void write_ptx(const Options& o, const std::string& bin) {
  if (o.ptx.empty()) return;
  std::ofstream out(o.ptx, std::ios::binary);
  out << bin;
  std::printf("wrote %s (%zu bytes)\n", o.ptx.c_str(), bin.size());
}

bool check_ok(const Options& o, double err) {
  if (err <= o.tol) return true;
  std::fprintf(stderr, "bench: %s FAILED the correctness check: max_rel_err=%.3g > %.1g\n",
               o.kernel.c_str(), err, o.tol);
  return false;
}

double write_ms(clk::Env& env, cl::Buffer& buf, const clk::HostMatrix& m) {
  cl::Event ev;
  env.q.enqueueWriteBuffer(buf, CL_FALSE, 0, m.bytes(), m.data(), nullptr, &ev);
  ev.wait();
  return clk::event_ms(ev);
}

double read_ms(clk::Env& env, const cl::Buffer& buf, clk::HostMatrix& m) {
  cl::Event ev;
  env.q.enqueueReadBuffer(buf, CL_FALSE, 0, m.bytes(), m.data(), nullptr, &ev);
  ev.wait();
  return clk::event_ms(ev);
}

int run_gemm(const Options& o, clk::Env& env) {
  clk::Gemm g(env, o.kernel, o.opts, o.local);
  if (!g.invalid().empty()) {
    std::fprintf(stderr, "bench: %s %s is not runnable here: %s\n", o.kernel.c_str(),
                 o.opts.c_str(), g.invalid().c_str());
    return 3;
  }
  write_ptx(o, g.binary());
  if (o.buildLog) std::printf("%s\n", g.build_log().c_str());

  const std::size_t n = std::size_t(o.n);
  clk::HostMatrix A(n), B(n), C(n);
  std::mt19937 rng(o.seed);
  A.fill_random(rng);
  B.fill_random(rng);
  cl::Buffer dA(env.ctx, CL_MEM_READ_ONLY, A.bytes()), dB(env.ctx, CL_MEM_READ_ONLY, B.bytes());
  cl::Buffer dC(env.ctx, CL_MEM_WRITE_ONLY, C.bytes());

  // Copies are timed separately (median of 3), so kernel times can be reported with or without them.
  std::vector<double> h2d, d2h;
  for (int i = 0; i < 3; ++i) h2d.push_back(write_ms(env, dA, A) + write_ms(env, dB, B));

  g.run(o.n, dA, dB, dC);  // warm-up: pays one-time costs; its result is the one checked
  for (int i = 0; i < 3; ++i) d2h.push_back(read_ms(env, dC, C));
  double err = NAN;
  if (o.check) {
    err = clk::gemm_check(A, B, C);
    if (!check_ok(o, err)) return 1;
  }

  std::vector<double> t;
  for (unsigned r = 0; r < o.reps; ++r) t.push_back(g.run(o.n, dA, dB, dC));
  Row row;
  row.kernel = o.kernel;
  row.opts = o.opts;
  row.local = g.local_str();
  row.n = std::to_string(o.n);
  row.reps = o.reps;
  row.med = median(t);
  row.best = *std::min_element(t.begin(), t.end());
  row.gflops = 2.0 * double(n) * double(n) * double(n) / (row.med * 1e-3) / 1e9;
  row.h2d = median(h2d);
  row.d2h = median(d2h);
  row.err = err;
  row.ptxas = g.ptxas();
  emit(o, env, row);
  return 0;
}

// Checks a few rows (first, last and 30 random ones) against the double-precision reference.
double check_rows(const Options& o, const clk::HostMatrix& x, const clk::HostMatrix& y,
                  const std::vector<float>& gamma, const std::vector<float>& beta, bool layernorm) {
  std::mt19937 rng(o.seed + 1);
  std::vector<std::size_t> rows = {0, x.rows() - 1};
  std::uniform_int_distribution<std::size_t> pick(0, x.rows() - 1);
  for (int i = 0; i < 30; ++i) rows.push_back(pick(rng));
  clk::HostMatrix xs(rows.size(), x.cols()), ys(rows.size(), x.cols());
  for (std::size_t i = 0; i < rows.size(); ++i)
    for (std::size_t j = 0; j < x.cols(); ++j) xs(i, j) = x(rows[i], j), ys(i, j) = y(rows[i], j);
  const auto ref =
      layernorm ? clk::layernorm_ref(xs, gamma, beta, 1e-5) : clk::softmax_ref(xs, 1.0);
  return clk::max_rel_err(ys, ref);
}

int run_rows(const Options& o, clk::Env& env) {
  clk::RowKernel rk(env, o.kernel, o.opts);
  if (const std::string why = rk.invalid(o.cols); !why.empty()) {
    std::fprintf(stderr, "bench: %s %s is not runnable here: %s\n", o.kernel.c_str(),
                 o.opts.c_str(), why.c_str());
    return 3;
  }
  write_ptx(o, rk.binary());
  if (o.buildLog) std::printf("%s\n", rk.build_log().c_str());

  const std::size_t R = std::size_t(o.rows), C = std::size_t(o.cols);
  clk::HostMatrix x(R, C), y(R, C);
  std::mt19937 rng(o.seed);
  x.fill_random(rng);
  std::vector<float> gamma(C), beta(C);
  std::uniform_real_distribution<float> dist(-1.0f, 1.0f);
  for (std::size_t j = 0; j < C; ++j) gamma[j] = 1.0f + 0.5f * dist(rng), beta[j] = dist(rng);
  cl::Buffer dx(env.ctx, CL_MEM_READ_ONLY, x.bytes()), dy(env.ctx, CL_MEM_WRITE_ONLY, y.bytes());
  cl::Buffer dg(env.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, C * sizeof(float), gamma.data());
  cl::Buffer db(env.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, C * sizeof(float), beta.data());

  std::vector<double> h2d, d2h;
  for (int i = 0; i < 3; ++i) h2d.push_back(write_ms(env, dx, x));
  auto run = [&] {
    return rk.is_layernorm() ? rk.layernorm(o.rows, o.cols, 1e-5f, dx, dg, db, dy)
                             : rk.softmax(o.rows, o.cols, 1.0f, dx, dy);
  };
  run();
  for (int i = 0; i < 3; ++i) d2h.push_back(read_ms(env, dy, y));
  double err = NAN;
  if (o.check) {
    err = check_rows(o, x, y, gamma, beta, rk.is_layernorm());
    if (!check_ok(o, err)) return 1;
  }

  std::vector<double> t;
  for (unsigned r = 0; r < o.reps; ++r) t.push_back(run());
  Row row;
  row.kernel = o.kernel;
  row.opts = o.opts;
  row.local = rk.local_str();
  row.rows = std::to_string(o.rows);
  row.cols = std::to_string(o.cols);
  row.reps = o.reps;
  row.med = median(t);
  row.best = *std::min_element(t.begin(), t.end());
  // Effective bandwidth counts only the bytes that must move: read x once, write y once.
  row.gbps = 2.0 * double(R) * double(C) * sizeof(float) / (row.med * 1e-3) / 1e9;
  row.h2d = median(h2d);
  row.d2h = median(d2h);
  row.err = err;
  row.ptxas = rk.ptxas();
  emit(o, env, row);
  return 0;
}

// One attention head, O = softmax(Q K^T / sqrt(d)) V, as separate launches. Unfused runs a scale
// pass over the L x L scores; fused folds 1/sqrt(d) into the softmax kernel.
int run_attention(const Options& o, clk::Env& env) {
  const bool fused = o.kernel == "attn_fused";
  const std::string gopts = o.opts.empty() ? "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4" : o.opts;
  const int L = o.l, d = o.d;
  const std::size_t LL = std::size_t(L) * L, Ld = std::size_t(L) * d;
  const float s = 1.0f / std::sqrt(float(d));

  clk::HostMatrix Q(L, d), K(L, d), V(L, d), O(L, d);
  std::mt19937 rng(o.seed);
  Q.fill_random(rng);
  K.fill_random(rng);
  V.fill_random(rng);
  cl::Buffer dQ(env.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, Q.bytes(), Q.data());
  cl::Buffer dK(env.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, K.bytes(), K.data());
  cl::Buffer dV(env.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, V.bytes(), V.data());
  cl::Buffer dKt(env.ctx, CL_MEM_READ_WRITE, Ld * sizeof(float));
  cl::Buffer dS(env.ctx, CL_MEM_READ_WRITE, LL * sizeof(float));
  cl::Buffer dP(env.ctx, CL_MEM_READ_WRITE, LL * sizeof(float));
  cl::Buffer dO(env.ctx, CL_MEM_WRITE_ONLY, O.bytes());
  clk::RowKernel sm(env, "softmax_online", "-DWG=256");

  struct Stage {
    std::string name;
    double flops, bytes;  // minimum bytes that must cross the memory bus
    std::vector<double> t;
  };
  const double f = sizeof(float);
  std::vector<Stage> st = {{"transpose", 0, 2 * Ld * f, {}},
                           {"qk", 2.0 * LL * d, (2 * Ld + LL) * f, {}}};
  if (!fused) st.push_back({"scale", 0, 2 * LL * f, {}});
  st.push_back({fused ? "softmax_scaled" : "softmax", 0, 2 * LL * f, {}});
  st.push_back({"pv", 2.0 * LL * d, (LL + 2 * Ld) * f, {}});

  auto pipeline = [&](bool record) {
    std::vector<double> t;
    t.push_back(clk::transpose(env, L, d, dK, dKt));
    t.push_back(clk::gemm_mnk(env, gopts, L, L, d, dQ, dKt, dS));
    if (!fused) t.push_back(clk::scale(env, int(LL), s, dS));
    t.push_back(sm.softmax(L, L, fused ? s : 1.0f, dS, dP));
    t.push_back(clk::gemm_mnk(env, gopts, L, d, L, dP, dV, dO));
    if (record)
      for (std::size_t i = 0; i < st.size(); ++i) st[i].t.push_back(t[i]);
  };

  pipeline(false);
  env.q.enqueueReadBuffer(dO, CL_TRUE, 0, O.bytes(), O.data());
  double err = NAN;
  if (o.check) {
    std::vector<std::size_t> rows = {0, std::size_t(L) - 1};
    std::mt19937 pr(o.seed + 1);
    std::uniform_int_distribution<std::size_t> pick(0, std::size_t(L) - 1);
    for (int i = 0; i < 14; ++i) rows.push_back(pick(pr));
    const auto ref = clk::attention_ref_rows(Q, K, V, s, rows);
    clk::HostMatrix got(rows.size(), std::size_t(d));
    for (std::size_t i = 0; i < rows.size(); ++i)
      for (int j = 0; j < d; ++j) got(i, std::size_t(j)) = O(rows[i], std::size_t(j));
    err = clk::max_rel_err(got, ref);
    if (!check_ok(o, err)) return 1;
  }
  for (unsigned r = 0; r < o.reps; ++r) pipeline(true);

  double totalMed = 0, totalBytes = 0, totalFlops = 0;
  for (const auto& stage : st) {
    Row row;
    row.kernel = o.kernel + "/" + stage.name;
    row.opts = gopts;
    row.rows = std::to_string(L);
    row.cols = std::to_string(d);
    row.reps = o.reps;
    row.med = median(stage.t);
    row.best = *std::min_element(stage.t.begin(), stage.t.end());
    if (stage.flops > 0) row.gflops = stage.flops / (row.med * 1e-3) / 1e9;
    row.gbps = stage.bytes / (row.med * 1e-3) / 1e9;
    emit(o, env, row);
    totalMed += row.med, totalBytes += stage.bytes, totalFlops += stage.flops;
  }
  Row total;
  total.kernel = o.kernel + "/total";
  total.opts = gopts;
  total.rows = std::to_string(L);
  total.cols = std::to_string(d);
  total.reps = o.reps;
  total.med = total.best = totalMed;  // sum of per-stage medians
  total.gflops = totalFlops / (totalMed * 1e-3) / 1e9;
  total.gbps = totalBytes / (totalMed * 1e-3) / 1e9;
  total.err = err;
  emit(o, env, total);
  return 0;
}

void set_env(const char* name, const char* value) {
#ifdef _WIN32
  _putenv_s(name, value);
#else
  setenv(name, value, 1);
#endif
}

bool is_in(const std::string& k, const std::vector<std::string>& v) {
  return std::find(v.begin(), v.end(), k) != v.end();
}

}  // namespace

int main(int argc, char** argv) {
  const Options o = parse(argc, argv);
  try {
    // NVIDIA serves repeated builds from its compute cache, whose log has no ptxas output.
    if (o.registers) set_env("CUDA_CACHE_DISABLE", "1");
    clk::Env env(o.device);
    if (o.registers && env.is_nvidia()) env.common_opts = "-cl-nv-verbose";
    if (is_in(o.kernel, clk::Gemm::names()) || o.kernel == "clblast") return run_gemm(o, env);
    if (is_in(o.kernel, clk::RowKernel::names())) return run_rows(o, env);
    if (o.kernel == "attn_unfused" || o.kernel == "attn_fused") return run_attention(o, env);
    std::fprintf(stderr, "bench: unknown kernel '%s' (see --list)\n", o.kernel.c_str());
    return 2;
  } catch (const cl::Error& e) {
    std::fprintf(stderr, "bench: %s\n", clk::describe(e).c_str());
    return 1;
  } catch (const std::exception& e) {
    std::fprintf(stderr, "bench: %s\n", e.what());
    return 1;
  }
}
