// Correctness tests for every kernel at awkward sizes, against double-precision CPU references.
// Runs on whatever OpenCL device is selected: the RTX 4060 on the laptop, PoCL (CPU) in CI.
// usage: test_kernels [device-name-substring]

#include <algorithm>
#include <array>
#include <cmath>
#include <cstdio>
#include <random>
#include <string>
#include <vector>

#include "clkernels/env.hpp"
#include "clkernels/gemm.hpp"
#include "clkernels/host_matrix.hpp"
#include "clkernels/reference.hpp"
#include "clkernels/softmax.hpp"

namespace {

int failures = 0, checks = 0, skipped = 0;

void expect(bool ok, const std::string& what) {
  ++checks;
  if (!ok) {
    ++failures;
    std::printf("FAIL: %s\n", what.c_str());
  }
}

std::string fmt(const char* f, double v) {
  char buf[64];
  std::snprintf(buf, sizeof buf, f, v);
  return buf;
}

cl::Buffer to_device(clk::Env& e, const clk::HostMatrix& m) {
  return cl::Buffer(e.ctx, CL_MEM_READ_WRITE | CL_MEM_COPY_HOST_PTR, m.bytes(),
                    const_cast<float*>(m.data()));
}

cl::Buffer to_device(clk::Env& e, const std::vector<float>& v) {
  return cl::Buffer(e.ctx, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, v.size() * sizeof(float),
                    const_cast<float*>(v.data()));
}

void from_device(clk::Env& e, const cl::Buffer& b, clk::HostMatrix& m) {
  e.q.enqueueReadBuffer(b, CL_TRUE, 0, m.bytes(), m.data());
}

struct GemmCase {
  std::string kernel, opts;
  std::vector<std::size_t> local;
};

std::string label(const GemmCase& c) {
  std::string s = c.kernel;
  if (!c.opts.empty()) s += " " + c.opts;
  if (c.local.size() == 2) s += " " + std::to_string(c.local[0]) + "x" + std::to_string(c.local[1]);
  return s;
}

// --- GEMM ---------------------------------------------------------------------------------------

void test_gemm(clk::Env& e) {
  const std::vector<GemmCase> cases = {
      {"gemm_naive", "", {16, 16}},
      {"gemm_naive", "", {32, 8}},
      {"gemm_naive_bad", "", {16, 16}},
      {"gemm_tiled", "-DTS=8", {}},
      {"gemm_tiled", "-DTS=16", {}},
      {"gemm_tiled", "-DTS=32", {}},
      {"gemm_reg", "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4", {}},
      {"gemm_reg", "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4 -DCONTIG=1", {}},
      {"gemm_reg", "-DTSM=32 -DTSN=32 -DTSK=8 -DWPTM=2 -DWPTN=2", {}},
      {"gemm_reg", "-DTSM=16 -DTSN=16 -DTSK=16 -DWPTM=1 -DWPTN=1", {}},  // WPT = 1
      {"gemm_reg", "-DTSM=64 -DTSN=64 -DTSK=8 -DWPTM=8 -DWPTN=8", {}},
      {"gemm_reg", "-DTSM=128 -DTSN=128 -DTSK=16 -DWPTM=8 -DWPTN=8", {}},
      {"gemm_reg", "-DTSM=64 -DTSN=32 -DTSK=16 -DWPTM=8 -DWPTN=2", {}},  // rectangular tile
  };
  const std::vector<int> sizes = {1,  2,  3,  15,  16,  17,  31,  32,  33,  63,
                                  64, 65, 100, 127, 128, 129, 1000};

  std::mt19937 rng(1);
  for (int n : sizes) {
    clk::HostMatrix A{std::size_t(n)}, B{std::size_t(n)}, C{std::size_t(n)};
    A.fill_random(rng);
    B.fill_random(rng);
    const auto R = clk::gemm_ref(A, B);
    cl::Buffer dA = to_device(e, A), dB = to_device(e, B), dC = to_device(e, C);
    for (const auto& c : cases) {
      clk::Gemm g(e, c.kernel, c.opts, c.local);
      if (!g.invalid().empty()) {
        if (n == 1) std::printf("skip: %s (%s)\n", label(c).c_str(), g.invalid().c_str());
        ++skipped;
        continue;
      }
      g.run(n, dA, dB, dC);
      from_device(e, dC, C);
      const double err = clk::max_rel_err(C, R);
      expect(err <= 1e-4, label(c) + " N=" + std::to_string(n) + fmt(" err=%.3g", err));
    }
  }

  // Identity: C = I * B must equal B exactly. Tolerances hide swapped indices; this does not.
  for (int n : {17, 64, 129}) {
    clk::HostMatrix I{std::size_t(n)}, B{std::size_t(n)}, C{std::size_t(n)};
    for (std::size_t i = 0; i < I.size(); ++i) I.data()[i] = 0.0f;
    for (int i = 0; i < n; ++i) I(std::size_t(i), std::size_t(i)) = 1.0f;
    B.fill_random(rng);
    cl::Buffer dI = to_device(e, I), dB = to_device(e, B), dC = to_device(e, C);
    for (const auto& c : cases) {
      clk::Gemm g(e, c.kernel, c.opts, c.local);
      if (!g.invalid().empty()) continue;
      g.run(n, dI, dB, dC);
      from_device(e, dC, C);
      bool exact = true;
      for (std::size_t i = 0; i < C.size(); ++i) exact &= C.data()[i] == B.data()[i];
      expect(exact, label(c) + " identity N=" + std::to_string(n));
    }
  }

  // The host must reject configurations that break kernel 3's rules instead of launching them.
  expect(!clk::check_reg_config(e, 64, 64, 16, 3, 4).empty(), "reject TSM % WPTM != 0");
  expect(!clk::check_reg_config(e, 64, 64, 2, 2, 2).empty(), "reject (TSM*TSK) % NWI != 0");
  expect(!clk::check_reg_config(e, 512, 512, 32, 1, 1).empty(), "reject too many work-items");
  expect(clk::check_reg_config(e, 64, 64, 16, 4, 4).empty(), "accept 64/64/16/4/4");
}

// gemm_mnk and transpose, used by the attention step.
void test_mnk(clk::Env& e) {
  std::mt19937 rng(2);
  const std::string opts = "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4";
  for (auto [M, N, K] : std::vector<std::array<int, 3>>{{1, 1, 1}, {65, 33, 17}, {100, 64, 64},
                                                        {64, 100, 129}, {130, 64, 300}}) {
    clk::HostMatrix A{std::size_t(M), std::size_t(K)}, B{std::size_t(K), std::size_t(N)};
    clk::HostMatrix C{std::size_t(M), std::size_t(N)};
    A.fill_random(rng);
    B.fill_random(rng);
    cl::Buffer dA = to_device(e, A), dB = to_device(e, B), dC = to_device(e, C);
    clk::gemm_mnk(e, opts, M, N, K, dA, dB, dC);
    from_device(e, dC, C);
    const double err = clk::max_rel_err(C, clk::gemm_ref(A, B));
    expect(err <= 1e-4, "gemm_mnk " + std::to_string(M) + "x" + std::to_string(N) + "x" +
                            std::to_string(K) + fmt(" err=%.3g", err));
  }
  for (auto [R, C] : std::vector<std::array<int, 2>>{{1, 1}, {17, 33}, {64, 64}, {100, 7}}) {
    clk::HostMatrix in{std::size_t(R), std::size_t(C)}, out{std::size_t(C), std::size_t(R)};
    in.fill_random(rng);
    cl::Buffer din = to_device(e, in), dout = to_device(e, out);
    clk::transpose(e, R, C, din, dout);
    from_device(e, dout, out);
    bool exact = true;
    for (int i = 0; i < R; ++i)
      for (int j = 0; j < C; ++j) exact &= out(std::size_t(j), std::size_t(i)) == in(std::size_t(i), std::size_t(j));
    expect(exact, "transpose " + std::to_string(R) + "x" + std::to_string(C));
  }
}

// --- softmax ------------------------------------------------------------------------------------

clk::HostMatrix run_softmax(clk::Env& e, clk::RowKernel& k, const clk::HostMatrix& x, float scale) {
  clk::HostMatrix y(x.rows(), x.cols());
  cl::Buffer dx = to_device(e, x), dy = to_device(e, y);
  k.softmax(int(x.rows()), int(x.cols()), scale, dx, dy);
  from_device(e, dy, y);
  return y;
}

void test_softmax(clk::Env& e) {
  const std::vector<std::pair<std::string, std::string>> cases = {
      {"softmax_naive", ""},           {"softmax_wg", "-DWG=64"},
      {"softmax_wg", "-DWG=256"},      {"softmax_online", "-DWG=64"},
      {"softmax_online", "-DWG=256"},  {"softmax_online", "-DWG=1024"},
      {"softmax_cached", "-DWG=256"},
  };
  const std::vector<std::array<int, 2>> shapes = {{1, 1},   {3, 7},    {5, 100}, {64, 255},
                                                  {7, 256}, {9, 1000}, {2, 4097}};
  std::mt19937 rng(3);
  for (const auto& [kernel, opts] : cases) {
    clk::RowKernel k(e, kernel, opts);
    const std::string name = kernel + " " + opts;
    for (auto [R, C] : shapes) {
      if (!k.invalid(C).empty()) {
        ++skipped;
        continue;
      }
      const std::string shape = " " + std::to_string(R) + "x" + std::to_string(C);
      clk::HostMatrix x{std::size_t(R), std::size_t(C)};
      x.fill_random(rng, -4.0f, 4.0f);

      // Against the reference, and every row sums to 1.
      const clk::HostMatrix y = run_softmax(e, k, x, 1.0f);
      const double err = clk::max_rel_err(y, clk::softmax_ref(x, 1.0));
      expect(err <= 1e-5, name + shape + fmt(" err=%.3g", err));
      double worst = 0.0;
      for (int r = 0; r < R; ++r) {
        double s = 0.0;
        for (int j = 0; j < C; ++j) s += y(std::size_t(r), std::size_t(j));
        worst = std::max(worst, std::abs(s - 1.0));
      }
      expect(worst <= 1e-5, name + shape + fmt(" row sum off by %.3g", worst));

      // A scale factor (the fused attention path) matches the reference too.
      const double errScaled = clk::max_rel_err(run_softmax(e, k, x, 0.125f), clk::softmax_ref(x, 0.125));
      expect(errScaled <= 1e-5, name + shape + fmt(" scaled err=%.3g", errScaled));

      // Shift invariance: softmax(x + 100) = softmax(x). Adding 100 in float rounds x to about
      // 8e-6, which is what the tolerance allows for.
      clk::HostMatrix xs{std::size_t(R), std::size_t(C)};
      for (std::size_t i = 0; i < x.size(); ++i) xs.data()[i] = x.data()[i] + 100.0f;
      const double errShift = clk::max_rel_err(run_softmax(e, k, xs, 1.0f), clk::softmax_ref(x, 1.0));
      expect(errShift <= 1e-4, name + shape + fmt(" shift err=%.3g", errShift));

      // Overflow: values near 1000 must not produce inf or NaN.
      clk::HostMatrix xo{std::size_t(R), std::size_t(C)};
      for (std::size_t i = 0; i < x.size(); ++i) xo.data()[i] = 1000.0f + x.data()[i];
      const clk::HostMatrix yo = run_softmax(e, k, xo, 1.0f);
      bool finite = true;
      for (std::size_t i = 0; i < yo.size(); ++i) finite &= std::isfinite(yo.data()[i]);
      expect(finite, name + shape + " overflow: non-finite output");
    }
  }

  // Short rows with a big work-group: most work-items get no elements (the online NaN guard).
  for (int C : {1, 7, 100}) {
    clk::RowKernel k(e, "softmax_online", "-DWG=256");
    clk::HostMatrix x(4, std::size_t(C));
    x.fill_random(rng);
    const double err = clk::max_rel_err(run_softmax(e, k, x, 1.0f), clk::softmax_ref(x, 1.0));
    expect(err <= 1e-5, "softmax_online short row C=" + std::to_string(C) + fmt(" err=%.3g", err));
  }

  // The cached kernel must refuse rows that do not fit in local memory.
  clk::RowKernel cached(e, "softmax_cached", "-DWG=256");
  expect(!cached.invalid(int(e.local_mem() / sizeof(float))).empty(), "softmax_cached rejects big C");
}

// --- layer norm ---------------------------------------------------------------------------------

double run_layernorm(clk::Env& e, const std::string& kernel, const clk::HostMatrix& x,
                     const std::vector<float>& gamma, const std::vector<float>& beta) {
  clk::RowKernel k(e, kernel, "-DWG=256");
  clk::HostMatrix y(x.rows(), x.cols());
  cl::Buffer dx = to_device(e, x), dy = to_device(e, y);
  cl::Buffer dg = to_device(e, gamma), db = to_device(e, beta);
  k.layernorm(int(x.rows()), int(x.cols()), 1e-5f, dx, dg, db, dy);
  from_device(e, dy, y);
  return clk::max_rel_err(y, clk::layernorm_ref(x, gamma, beta, 1e-5));
}

void test_layernorm(clk::Env& e) {
  std::mt19937 rng(4);
  for (auto [R, C] : std::vector<std::array<int, 2>>{{1, 1}, {3, 7}, {5, 100}, {4, 1024}, {3, 3000}}) {
    clk::HostMatrix x{std::size_t(R), std::size_t(C)};
    x.fill_random(rng, -2.0f, 3.0f);
    std::vector<float> gamma(static_cast<std::size_t>(C)), beta(static_cast<std::size_t>(C));
    std::uniform_real_distribution<float> d(-1.0f, 1.0f);
    for (int j = 0; j < C; ++j) gamma[std::size_t(j)] = 1.0f + 0.5f * d(rng), beta[std::size_t(j)] = d(rng);
    if (C == 1) gamma[0] = 1.0f, beta[0] = 0.5f;  // variance 0: output is beta
    const double err = run_layernorm(e, "layernorm", x, gamma, beta);
    expect(err <= 1e-4, "layernorm " + std::to_string(R) + "x" + std::to_string(C) + fmt(" err=%.3g", err));
  }

  // Large offset: x = 1e6 + noise. Welford/Chan works on deviations and stays accurate;
  // sum-of-squares loses everything to cancellation (printed for the README, not asserted).
  const int R = 4, C = 4096;
  clk::HostMatrix x(R, C);
  std::uniform_real_distribution<float> noise(-100.0f, 100.0f);
  for (std::size_t i = 0; i < x.size(); ++i) x.data()[i] = 1e6f + noise(rng);
  std::vector<float> gamma(C, 1.0f), beta(C, 0.0f);
  const double errWelford = run_layernorm(e, "layernorm", x, gamma, beta);
  const double errNaive = run_layernorm(e, "layernorm_naive", x, gamma, beta);
  std::printf("layer norm at 1e6 + noise: Welford/Chan err=%.3g, sum-of-squares err=%.3g\n",
              errWelford, errNaive);
  expect(errWelford <= 2e-3, "layernorm 1e6 offset" + fmt(" err=%.3g", errWelford));
}

// --- attention (small, end to end through the same kernels the bench uses) ----------------------

void test_attention(clk::Env& e) {
  const int L = 100, d = 64;
  std::mt19937 rng(5);
  clk::HostMatrix Q(L, d), K(L, d), V(L, d), Kt(d, L), S(L, L), P(L, L), O(L, d);
  Q.fill_random(rng);
  K.fill_random(rng);
  V.fill_random(rng);
  cl::Buffer dQ = to_device(e, Q), dK = to_device(e, K), dV = to_device(e, V);
  cl::Buffer dKt = to_device(e, Kt), dS = to_device(e, S), dP = to_device(e, P), dO = to_device(e, O);
  const std::string opts = "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4";
  const float s = 1.0f / std::sqrt(float(d));
  clk::RowKernel sm(e, "softmax_online", "-DWG=256");
  clk::transpose(e, L, d, dK, dKt);
  clk::gemm_mnk(e, opts, L, L, d, dQ, dKt, dS);
  sm.softmax(L, L, s, dS, dP);  // fused scale
  clk::gemm_mnk(e, opts, L, d, L, dP, dV, dO);
  from_device(e, dO, O);
  std::vector<std::size_t> rows(L);
  for (int i = 0; i < L; ++i) rows[std::size_t(i)] = std::size_t(i);
  const double err = clk::max_rel_err(O, clk::attention_ref_rows(Q, K, V, s, rows));
  expect(err <= 1e-4, "attention L=100 d=64" + fmt(" err=%.3g", err));
}

}  // namespace

int main(int argc, char** argv) {
  const std::string device = argc > 1 ? argv[1] : "";
  try {
    clk::Env e(device);
    std::printf("device: %s (%s)\n", e.device_name().c_str(), e.driver().c_str());
    test_gemm(e);
    test_mnk(e);
    test_softmax(e);
    test_layernorm(e);
    test_attention(e);
  } catch (const cl::Error& err) {
    std::printf("FAIL: OpenCL error: %s\n", clk::describe(err).c_str());
    return 1;
  } catch (const std::exception& err) {
    std::printf("FAIL: %s\n", err.what());
    return 1;
  }
  std::printf("%d checks, %d failures, %d skipped (device limits)\n", checks, failures, skipped);
  return failures ? 1 : 0;
}
