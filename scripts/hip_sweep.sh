#!/usr/bin/env bash
# HIP experiments on one GPU (run inside the ROCm environment, e.g. WSL Ubuntu). Every CSV goes to
# $OUT (default results/hip). bench_hip checks each configuration against the FP64 CPU reference
# before timing it and exits non-zero if any check fails.
#
#   BENCH=build-hip/bench_hip OUT=results/hip scripts/hip_sweep.sh [tuning|ownership|ladder|
#                                                                   rocblas|bandwidth|fma|clock|all]
#
# rocBLAS (5.2.0 in ROCm 7.2.4) ships no gfx1103 kernels. If it can't run natively, each entry
# VERSION=BENCH of ROCBLAS_OVERRIDE runs it with HSA_OVERRIDE_GFX_VERSION=VERSION (unofficial) using
# a bench_hip built for that target, e.g.
#   ROCBLAS_OVERRIDE="11.0.0=build-hip-gfx1100/bench_hip 11.0.2=build-hip-gfx1102/bench_hip"
# The CSV's arch column then records the overridden target.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BENCH="${BENCH:-$ROOT/build-hip/bench_hip}"
OUT="${OUT:-$ROOT/results/hip}"
REPS="${REPS:-20}"
COOL="${COOL:-1}"
QUICK="${QUICK:-0}"
mkdir -p "$OUT"

if [[ "$QUICK" == 1 ]]; then N_TUNE=(129); N_LADDER=(129); REPS=2; COOL=0
else N_TUNE=(2048 4096); N_LADDER=(256 512 1024 2048 3072 4096); fi

ns() { local a=(); for n in "$@"; do a+=(--n "$n"); done; echo "${a[@]}"; }

# A second process samples the shader clock every 0.25 s into hip_clock_<step>.csv while a step
# runs (the iGPU's clock moves with load and temperature; there is no nvidia-smi equivalent here).
monitor_start() {
  rm -f "$OUT/hip_clock_$1.csv"
  "$BENCH" --clock --seconds 100000 --interval 0.25 --csv "$OUT/hip_clock_$1.csv" > /dev/null &
  MONITOR=$!
}
monitor_stop() { kill "$MONITOR"; wait "$MONITOR" 2> /dev/null || true; }
fresh() { rm -f "$OUT/$1"; }

# Best kernel-3 configuration at the largest tuning N, as TSM,TSN,TSK,WPTM,WPTN.
best() {
  python3 - "$OUT/hip_tuning.csv" <<'EOF'
import csv, sys
rows = [r for r in csv.DictReader(open(sys.argv[1])) if r["kernel"] == "gemm_reg" and r["contig"] == "0"]
top = max(int(r["n"]) for r in rows)
b = max((r for r in rows if int(r["n"]) == top), key=lambda r: float(r["gflops"]))
print(",".join(b[k] for k in ("tsm", "tsn", "tsk", "wptm", "wptn")))
EOF
}

tuning() {
  fresh hip_tuning.csv
  # The OpenCL grid (54 points; bench_hip skips the ones that break the rules) plus one
  # configuration that only HIP can run on AMD: exactly 64 KB of tiles. (The grid's 128 x 128,
  # 4 x 4 points have 1,024 threads, which AMD's OpenCL driver also refuses.)
  monitor_start tuning
  "$BENCH" --grid --config 128,128,64,8,8 $(ns "${N_TUNE[@]}") --reps "$REPS" \
           --csv "$OUT/hip_tuning.csv"
  monitor_stop
  best > "$OUT/hip_best.txt"
  echo "hip_sweep: best = $(cat "$OUT/hip_best.txt")"
}

ownership() {
  fresh hip_ownership.csv
  local b; b="$(cat "$OUT/hip_best.txt")"
  monitor_start ownership
  for c in 64,64,16,4,4 128,128,8,8,8 "$b"; do
    "$BENCH" --config "$c" --config "$c,contig" --n "${N_TUNE[-1]}" --reps "$REPS" \
             --csv "$OUT/hip_ownership.csv"
    sleep "$COOL"
  done
  monitor_stop
}

ladder() {
  fresh hip_ladder.csv
  monitor_start ladder
  "$BENCH" --config "$(cat "$OUT/hip_best.txt")" $(ns "${N_LADDER[@]}") --reps "$REPS" \
           --csv "$OUT/hip_ladder.csv"
  monitor_stop
}

rocblas() {
  fresh hip_rocblas.csv
  if "$BENCH" --rocblas --n 256 --reps 1 > /dev/null 2>&1; then
    "$BENCH" --rocblas $(ns "${N_LADDER[@]}") --reps "$REPS" --csv "$OUT/hip_rocblas.csv"
    return
  fi
  echo "hip_sweep: rocBLAS has no kernels for this GPU's own target"
  monitor_start rocblas
  for entry in ${ROCBLAS_OVERRIDE:-}; do
    local v="${entry%%=*}" bench="${entry#*=}"
    HSA_OVERRIDE_GFX_VERSION="$v" "$bench" --rocblas $(ns "${N_LADDER[@]}") --reps "$REPS" \
      --csv "$OUT/hip_rocblas.csv" || echo "hip_sweep: rocBLAS with HSA_OVERRIDE_GFX_VERSION=$v failed"
  done
  monitor_stop
}

bandwidth() { fresh hip_bandwidth.csv; "$BENCH" --bandwidth --reps "$REPS" --csv "$OUT/hip_bandwidth.csv"; }
fma() { fresh hip_fma.csv; "$BENCH" --fma --reps "$REPS" --csv "$OUT/hip_fma.csv"; }

clock() {
  fresh hip_clock.csv
  "$BENCH" --clock --csv "$OUT/hip_clock.csv"  # idle
  "$BENCH" --clock --fma --csv "$OUT/hip_clock.csv"
  "$BENCH" --clock --config "$(cat "$OUT/hip_best.txt")" --n "${N_TUNE[-1]}" --csv "$OUT/hip_clock.csv"
}

# Does the clock monitor itself change the result? The best configuration, alternately without
# and with the monitor running.
monitorcheck() {
  fresh hip_monitor_off.csv; fresh hip_monitor_on.csv
  local b; b="$(cat "$OUT/hip_best.txt")"
  for _ in 1 2 3; do
    "$BENCH" --config "$b" --n "${N_TUNE[-1]}" --reps "$REPS" --csv "$OUT/hip_monitor_off.csv" > /dev/null
    monitor_start monitorcheck
    "$BENCH" --config "$b" --n "${N_TUNE[-1]}" --reps "$REPS" --csv "$OUT/hip_monitor_on.csv" > /dev/null
    monitor_stop
  done
}

# Larger tiles than the tuning grid, interleaved with the best grid point over three rounds: does
# more reuse per byte of global traffic help? (256 x 128 and 256 x 256 need 512 and 1,024
# threads, which AMD's OpenCL driver does not allow.)
tiles() {
  local d="$OUT/tiles"; mkdir -p "$d"; rm -f "$d"/*.csv
  local b; b="$(cat "$OUT/hip_best.txt")"
  local OUT_SAVE="$OUT"; OUT="$d"; monitor_start tiles; OUT="$OUT_SAVE"
  for r in 1 2 3; do
    for c in "$b" 256,128,16,8,8 256,256,16,8,8; do
      "$BENCH" --config "$c" $(ns "${N_TUNE[@]}") --reps "$REPS" --csv "$d/tiles.csv" > /dev/null
    done
  done
  monitor_stop
}

"$BENCH" --info > "$OUT/hip_device.txt"
case "${1:-all}" in
  all) tuning; ownership; ladder; rocblas; bandwidth; fma; clock; monitorcheck ;;
  tuning-only) tuning ;;
  *) "$1" ;;
esac
