#pragma once

#include <cstddef>
#include <cstdlib>
#include <memory>
#include <new>
#include <random>

#ifdef _WIN32
#include <malloc.h>
#endif

namespace clk {

// Row-major, 64-byte-aligned float matrix on the host (the Matmul project's Matrix, generalized
// to rows x cols). Move-only.
class HostMatrix {
 public:
  HostMatrix(std::size_t rows, std::size_t cols)
      : rows_(rows), cols_(cols), data_(allocate(rows * cols)) {}
  explicit HostMatrix(std::size_t n) : HostMatrix(n, n) {}
  HostMatrix(HostMatrix&&) noexcept = default;
  HostMatrix& operator=(HostMatrix&&) noexcept = default;
  HostMatrix(const HostMatrix&) = delete;  // copying 64 MB by accident is a bug
  HostMatrix& operator=(const HostMatrix&) = delete;

  std::size_t rows() const { return rows_; }
  std::size_t cols() const { return cols_; }
  std::size_t size() const { return rows_ * cols_; }
  std::size_t bytes() const { return size() * sizeof(float); }
  float* data() { return data_.get(); }
  const float* data() const { return data_.get(); }
  float& operator()(std::size_t i, std::size_t j) { return data_[i * cols_ + j]; }
  float operator()(std::size_t i, std::size_t j) const { return data_[i * cols_ + j]; }

  // Uniform in [lo, hi] from a fixed-seed generator, so every run sees the same inputs.
  void fill_random(std::mt19937& rng, float lo = -1.0f, float hi = 1.0f) {
    std::uniform_real_distribution<float> dist(lo, hi);
    for (std::size_t i = 0; i < size(); ++i) data_[i] = dist(rng);
  }

 private:
  struct Free {
    void operator()(float* p) const noexcept {
#ifdef _WIN32
      _aligned_free(p);  // MSVC has no std::aligned_alloc
#else
      std::free(p);
#endif
    }
  };

  static float* allocate(std::size_t count) {
    std::size_t bytes = count * sizeof(float);
    bytes = (bytes + 63) / 64 * 64;  // aligned_alloc needs a multiple of the alignment
    if (bytes == 0) bytes = 64;
#ifdef _WIN32
    void* p = _aligned_malloc(bytes, 64);
#else
    void* p = std::aligned_alloc(64, bytes);
#endif
    if (!p) throw std::bad_alloc{};
    return static_cast<float*>(p);
  }

  std::size_t rows_, cols_;
  std::unique_ptr<float[], Free> data_;
};

}  // namespace clk
