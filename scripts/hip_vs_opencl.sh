#!/usr/bin/env bash
# Head-to-head on the Radeon 780M, interleaved: on this APU the clock and the throughput drift by
# tens of percent over minutes of load (results/hip/repeat), so contenders measured in separate
# sweeps are not comparable. Each round runs every contender once (warm-up + 20 timed launches,
# median) at each N, rotating the order every round, while bench_hip's clock probe samples the GPU
# every 0.25 s. Run from Git Bash on Windows; the HIP contenders run in WSL.
#
#   scripts/hip_vs_opencl.sh [rounds]            N = 2048 and 4096 -> results/hip/h2h
#   NS="256 512 1024 2048 3072 4096" OUT_NAME=h2h_ladder scripts/hip_vs_opencl.sh 3
#
# Contenders: OpenCL gemm_reg through AMD's Windows driver; HIP gemm_reg wave32 and wave64 under
# ROCm in WSL; rocBLAS sgemm with gfx1100 kernels via HSA_OVERRIDE_GFX_VERSION=11.0.0 (unofficial:
# rocBLAS ships no gfx1103 kernels).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ROUNDS="${1:-5}"
NS="${NS:-2048 4096}"
OUT_NAME="${OUT_NAME:-h2h}"
OUT="$ROOT/results/hip/$OUT_NAME"
WOUT="${WOUT:-/mnt/c/Users/Varshith/Documents/matmulgpu/results/hip/$OUT_NAME}"  # $OUT seen from WSL
OCL="$ROOT/build/bench"
H="${WSL_BUILD_ROOT:-/home/varshith}"
IFS=, read -r m n k wm wn < "$ROOT/results/hip/hip_best.txt"
HIP_BEST="$m,$n,$k,$wm,$wn"
IFS=, read -r m n k wm wn < "$ROOT/results/hip/wave64/hip_best.txt"
HIP64_BEST="$m,$n,$k,$wm,$wn"
OCL_BEST="$(cat "$ROOT/results/hip/opencl_gfx1103/best_reg.txt")"
mkdir -p "$OUT"
rm -f "$OUT"/*.csv

wslrun() { MSYS_NO_PATHCONV=1 wsl -e env HSA_ENABLE_DXG_DETECTION=1 "$@"; }

contender() {
  local n=$2
  case "$1" in
    opencl) "$OCL" --device gfx1103 --kernel gemm_reg --n "$n" --opts "$OCL_BEST" --csv "$OUT/opencl.csv" ;;
    hip32) wslrun "$H/build-hip/bench_hip" --config "$HIP_BEST" --n "$n" --csv "$WOUT/hip_wave32.csv" ;;
    hip64) wslrun "$H/build-hip-w64/bench_hip" --config "$HIP64_BEST" --n "$n" --csv "$WOUT/hip_wave64.csv" ;;
    rocblas) MSYS_NO_PATHCONV=1 wsl -e env HSA_ENABLE_DXG_DETECTION=1 HSA_OVERRIDE_GFX_VERSION=11.0.0 \
               "$H/build-hip-gfx1100/bench_hip" --rocblas --n "$n" --csv "$WOUT/rocblas_gfx1100.csv" ;;
  esac > /dev/null
}

wslrun "$H/build-hip/bench_hip" --clock --seconds 100000 --interval 0.25 --csv "$WOUT/hip_clock_h2h.csv" \
  > /dev/null 2>&1 &
MONITOR=$!
trap 'MSYS_NO_PATHCONV=1 wsl -e pkill -f "[b]ench_hip --clock" || true; wait $MONITOR 2> /dev/null || true' EXIT
sleep 2

order=(opencl hip32 hip64 rocblas)
for ((r = 0; r < ROUNDS; ++r)); do
  for n in $NS; do
    for ((i = 0; i < ${#order[@]}; ++i)); do
      c="${order[$(( (i + r) % ${#order[@]} ))]}"
      contender "$c" "$n"
      echo "round $r N=$n $c done"
    done
  done
done
