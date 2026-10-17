#include "clkernels/reference.hpp"

#include <algorithm>
#include <cmath>
#include <limits>
#include <random>

namespace clk {

std::vector<double> gemm_ref(const HostMatrix& A, const HostMatrix& B) {
  const std::size_t M = A.rows(), K = A.cols(), N = B.cols();
  std::vector<double> R(M * N, 0.0);
  std::vector<double> brow(N);
  for (std::size_t i = 0; i < M; ++i) {
    double* r = &R[i * N];
    for (std::size_t k = 0; k < K; ++k) {  // i-k-j: both inner streams are stride 1
      const double a = A(i, k);
      const float* b = B.data() + k * N;
      for (std::size_t j = 0; j < N; ++j) r[j] += a * b[j];
    }
  }
  return R;
}

double max_rel_err(const HostMatrix& C, const std::vector<double>& R) {
  double maxDiff = 0.0, maxRef = 0.0;
  for (std::size_t i = 0; i < R.size(); ++i) {
    const double c = C.data()[i];
    if (!std::isfinite(c)) return std::numeric_limits<double>::infinity();
    maxDiff = std::max(maxDiff, std::abs(c - R[i]));
    maxRef = std::max(maxRef, std::abs(R[i]));
  }
  return maxRef > 0 ? maxDiff / maxRef : maxDiff;
}

double gemm_sampled_err(const HostMatrix& A, const HostMatrix& B, const HostMatrix& C,
                        std::size_t samples, unsigned seed) {
  const std::size_t M = A.rows(), K = A.cols(), N = B.cols();
  std::mt19937 rng(seed);
  std::uniform_int_distribution<std::size_t> ri(0, M - 1), rj(0, N - 1);
  double maxDiff = 0.0, maxRef = 0.0;
  for (std::size_t s = 0; s < samples; ++s) {
    const std::size_t i = ri(rng), j = rj(rng);
    double ref = 0.0;
    for (std::size_t k = 0; k < K; ++k) ref += double(A(i, k)) * double(B(k, j));
    const double c = C(i, j);
    if (!std::isfinite(c)) return std::numeric_limits<double>::infinity();
    maxDiff = std::max(maxDiff, std::abs(c - ref));
    maxRef = std::max(maxRef, std::abs(ref));
  }
  return maxRef > 0 ? maxDiff / maxRef : maxDiff;
}

double gemm_check(const HostMatrix& A, const HostMatrix& B, const HostMatrix& C) {
  if (A.rows() <= 1024 && B.cols() <= 1024) return max_rel_err(C, gemm_ref(A, B));
  return gemm_sampled_err(A, B, C, 1000, 7);
}

std::vector<double> softmax_ref(const HostMatrix& x, double scale) {
  const std::size_t R = x.rows(), C = x.cols();
  std::vector<double> y(R * C);
  for (std::size_t r = 0; r < R; ++r) {
    double m = -std::numeric_limits<double>::infinity();
    for (std::size_t j = 0; j < C; ++j) m = std::max(m, scale * x(r, j));
    double s = 0.0;
    for (std::size_t j = 0; j < C; ++j) s += std::exp(scale * x(r, j) - m);
    for (std::size_t j = 0; j < C; ++j) y[r * C + j] = std::exp(scale * x(r, j) - m) / s;
  }
  return y;
}

std::vector<double> layernorm_ref(const HostMatrix& x, const std::vector<float>& gamma,
                                  const std::vector<float>& beta, double eps) {
  const std::size_t R = x.rows(), C = x.cols();
  std::vector<double> y(R * C);
  for (std::size_t r = 0; r < R; ++r) {
    double mean = 0.0;
    for (std::size_t j = 0; j < C; ++j) mean += x(r, j);
    mean /= double(C);
    double var = 0.0;  // two passes in double: the exact answer to compare against
    for (std::size_t j = 0; j < C; ++j) var += (x(r, j) - mean) * (x(r, j) - mean);
    var /= double(C);
    const double rstd = 1.0 / std::sqrt(var + eps);
    for (std::size_t j = 0; j < C; ++j)
      y[r * C + j] = (x(r, j) - mean) * rstd * gamma[j] + beta[j];
  }
  return y;
}

std::vector<double> attention_ref_rows(const HostMatrix& Q, const HostMatrix& K,
                                       const HostMatrix& V, double scale,
                                       const std::vector<std::size_t>& rows) {
  const std::size_t L = Q.rows(), d = Q.cols();
  std::vector<double> out(rows.size() * d, 0.0), s(L);
  for (std::size_t ri = 0; ri < rows.size(); ++ri) {
    const std::size_t i = rows[ri];
    double m = -std::numeric_limits<double>::infinity();
    for (std::size_t j = 0; j < L; ++j) {
      double dot = 0.0;
      for (std::size_t t = 0; t < d; ++t) dot += double(Q(i, t)) * double(K(j, t));
      s[j] = dot * scale;
      m = std::max(m, s[j]);
    }
    double sum = 0.0;
    for (std::size_t j = 0; j < L; ++j) sum += (s[j] = std::exp(s[j] - m));
    for (std::size_t j = 0; j < L; ++j)
      for (std::size_t t = 0; t < d; ++t) out[ri * d + t] += s[j] / sum * double(V(j, t));
  }
  return out;
}

}  // namespace clk
