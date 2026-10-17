#pragma once

#include <cstddef>
#include <vector>

#include "clkernels/host_matrix.hpp"

namespace clk {

// R = A * B in double; A is M x K, B is K x N, R is M x N row-major. O(M N K): small sizes only.
std::vector<double> gemm_ref(const HostMatrix& A, const HostMatrix& B);

// max |C - R| / max |R|; infinity if C contains NaN or inf.
double max_rel_err(const HostMatrix& C, const std::vector<double>& R);

// Same metric over `samples` random entries of C, each recomputed in double from its row of A
// and column of B: O(samples * K), for sizes where the full reference is too slow.
double gemm_sampled_err(const HostMatrix& A, const HostMatrix& B, const HostMatrix& C,
                        std::size_t samples, unsigned seed);

// Full check up to N = 1024, sampled (1,000 entries) above it.
double gemm_check(const HostMatrix& A, const HostMatrix& B, const HostMatrix& C);

// Row-wise softmax of scale * x, and layer norm, in double.
std::vector<double> softmax_ref(const HostMatrix& x, double scale);
std::vector<double> layernorm_ref(const HostMatrix& x, const std::vector<float>& gamma,
                                  const std::vector<float>& beta, double eps);

// One head of attention, O = softmax(Q K^T * scale) V, for the listed rows only (O(L d) each).
// Q, K, V are L x d. Returns rows.size() * d values.
std::vector<double> attention_ref_rows(const HostMatrix& Q, const HostMatrix& K,
                                       const HostMatrix& V, double scale,
                                       const std::vector<std::size_t>& rows);

}  // namespace clk
