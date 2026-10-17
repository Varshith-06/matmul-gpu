#!/usr/bin/env bash
# The OpenCL baseline for the HIP port: kernel 3 on the Radeon 780M through AMD's Windows OpenCL
# driver, run from Git Bash on the same laptop. Writes results/hip/opencl_gfx1103/.
#
#   scripts/opencl_gfx1103.sh [tuning|ladder|ownership|all]
#
# If WSL with ROCm is available (WSL_BENCH_HIP names bench_hip inside it), bench_hip's clock probe
# samples the same GPU every 0.25 s from WSL while each step runs, as hip_sweep.sh does for HIP.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BENCH="${BENCH:-$ROOT/build/bench}"
OUT="$ROOT/results/hip/opencl_gfx1103"
DEVICE="${DEVICE:-gfx1103}"
REPS="${REPS:-20}"
WSL_BENCH_HIP="${WSL_BENCH_HIP:-}"
WSL_OUT="${WSL_OUT:-}"  # $OUT as seen from WSL
mkdir -p "$OUT"

monitor_start() {
  [[ -n "$WSL_BENCH_HIP" ]] || return 0
  rm -f "$OUT/hip_clock_$1.csv"
  # The wsl client stays in the background for the whole step; WSL ends a session's processes
  # when its client exits.
  MSYS_NO_PATHCONV=1 wsl -e env HSA_ENABLE_DXG_DETECTION=1 "$WSL_BENCH_HIP" --clock --seconds 100000     --interval 0.25 --csv "$WSL_OUT/hip_clock_$1.csv" > /dev/null 2>&1 &
  MONITOR=$!
  sleep 2
}
monitor_stop() {
  [[ -n "$WSL_BENCH_HIP" ]] || return 0
  MSYS_NO_PATHCONV=1 wsl -e pkill -f "[b]ench_hip --clock" || true  # [b]: don't match pkill itself
  wait "$MONITOR" 2> /dev/null || true
}

step="${1:-all}"
run() { [[ "$step" == all || "$step" == "$1" ]]; }

"$BENCH" --devices > "$OUT/devices.txt"

if run tuning; then
# Experiment 3 on this GPU: the same 54-point grid; configurations above the driver's
# 256-work-item limit are rejected before launch (bench exit code 3).
monitor_start tuning
python "$ROOT/scripts/tune.py" --device "$DEVICE" --no-clocks --reps "$REPS" --cool 0 --out "$OUT"
monitor_stop
fi

best="$(cat "$OUT/best_reg.txt")"
echo "opencl_gfx1103: best = $best"

if run ladder; then
# The ladder for OpenCL's own best configuration, and HIP's best configuration in OpenCL.
monitor_start ladder
rm -f "$OUT/ladder.csv" "$OUT/same_config.csv"
for n in 256 512 1024 2048 3072 4096; do
  "$BENCH" --device "$DEVICE" --kernel gemm_reg --n "$n" --opts "$best" --reps "$REPS" --csv "$OUT/ladder.csv"
done
if [[ -f "$ROOT/results/hip/hip_best.txt" ]]; then
  IFS=, read -r m n k wm wn < "$ROOT/results/hip/hip_best.txt"
  hb="-DTSM=$m -DTSN=$n -DTSK=$k -DWPTM=$wm -DWPTN=$wn"
  for n in 2048 4096; do
    "$BENCH" --device "$DEVICE" --kernel gemm_reg --n "$n" --opts "$hb" --reps "$REPS" --csv "$OUT/same_config.csv"
  done
fi
monitor_stop
fi

if run ownership; then
# The ownership experiment in OpenCL on this GPU.
monitor_start ownership
rm -f "$OUT/ownership.csv"
for o in "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4" "-DTSM=128 -DTSN=128 -DTSK=8 -DWPTM=8 -DWPTN=8" "$best"; do
  for c in "" " -DCONTIG=1"; do
    "$BENCH" --device "$DEVICE" --kernel gemm_reg --n 4096 --opts "$o$c" --reps "$REPS" --csv "$OUT/ownership.csv"
  done
done
monitor_stop
fi
