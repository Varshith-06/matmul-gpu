#!/usr/bin/env bash
# Runs the experiment grid and writes one CSV per experiment to $OUT, with a clock/temperature log
# (scripts/log_clocks.sh) running alongside each one.
#
#   scripts/sweep.sh                 # every experiment
#   scripts/sweep.sh ladder softmax  # just these
#
# Experiments: ladder ts coalescing ownership softmax softmax_wg layernorm cpu_gpu cpu attention
# (the kernel-3 tuning grid is scripts/tune.py).
#
# Environment:
#   BENCH      path to the bench executable   (default: build/bench or build/bench.exe)
#   DEVICE     device name substring          (default: "RTX 4060"; QUICK=1 defaults to "")
#   OUT        results directory              (default: results)
#   REPS       timed repetitions              (default: 20)
#   COOL       seconds of cool-down between configurations (default: 1)
#   BEST_REG   kernel-3 options for the ladder (default: results/best_reg.txt from tune.py)
#   BEST_TS    tile size for gemm_tiled in the ladder (default: 16)
#   CPU_BENCH  the Matmul project's bench executable, for the `cpu` experiment
#   QUICK=1    tiny sizes, 2 reps, no clock log: a smoke test for CI
# Works in Git Bash on Windows and on Linux.
set -euo pipefail
cd "$(dirname "$0")/.."

BENCH=${BENCH:-}
if [ -z "$BENCH" ]; then
  if [ -x build/bench.exe ]; then BENCH=build/bench.exe; else BENCH=build/bench; fi
fi
QUICK=${QUICK:-0}
if [ "$QUICK" = 1 ]; then DEVICE=${DEVICE:-}; else DEVICE=${DEVICE:-RTX 4060}; fi
OUT=${OUT:-results}
REPS=${REPS:-20}
COOL=${COOL:-1}
BEST_TS=${BEST_TS:-16}
if [ -z "${BEST_REG:-}" ]; then
  if [ -f "$OUT/best_reg.txt" ]; then BEST_REG=$(cat "$OUT/best_reg.txt")
  else BEST_REG="-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4"; fi
fi
mkdir -p "$OUT"

if [ "$QUICK" = 1 ]; then
  REPS=2 COOL=0
  GEMM_N="64 129"; BAD_N="64"; CPU_GPU_N="64 128"
  SM_ROWS=64; SM_COLS="128 1000"; WG_COLS="1000"; LN_COLS="1000"; ATT_L="128"
else
  GEMM_N="256 512 768 1024 1536 2048 3072 4096"
  BAD_N="1024 2048 4096"
  CPU_GPU_N="64 128 256 384 512 768 1024 1536 2048 3072 4096"
  SM_ROWS=4096; SM_COLS="128 256 512 1024 2048 4096 8192 16384 32768"
  WG_COLS="1024 4096 32768"; LN_COLS="1024 4096 16384"; ATT_L="512 1024 2048 4096"
fi

CLOCK_PID=""
start_clocks() {
  [ "$QUICK" = 1 ] && return 0
  command -v nvidia-smi > /dev/null || return 0
  scripts/log_clocks.sh "$OUT/clocks_$1.csv" &
  CLOCK_PID=$!
}
stop_clocks() {
  if [ -n "$CLOCK_PID" ]; then kill "$CLOCK_PID" 2> /dev/null || true; wait "$CLOCK_PID" 2> /dev/null || true; fi
  CLOCK_PID=""
}
trap stop_clocks EXIT

# One configuration. Exit code 3 means "not runnable on this device" (e.g. CLBlast not built, or a
# work-group too large for the CI driver): skip it. Anything else non-zero stops the sweep.
run() {
  local rc=0
  "$BENCH" --device "$DEVICE" --reps "$REPS" "$@" || rc=$?
  if [ $rc -eq 3 ]; then echo "  (skipped)"; elif [ $rc -ne 0 ]; then exit $rc; fi
  [ "$COOL" = 0 ] || sleep "$COOL"
}

begin() {
  echo "== $1 -> $OUT/$2"
  rm -f "$OUT/$2"
  start_clocks "$1"
}

exp_ladder() {  # Experiment 1: GEMM ladder (PyTorch/cuBLAS rows come from reference/torch_ref.py)
  local f=exp1_ladder.csv
  begin ladder $f
  for n in $GEMM_N; do
    run --kernel gemm_naive --n "$n" --local 16x16 --csv "$OUT/$f"
    run --kernel gemm_tiled --n "$n" --opts "-DTS=$BEST_TS" --csv "$OUT/$f"
    run --kernel gemm_reg --n "$n" --opts "$BEST_REG" --registers --csv "$OUT/$f"
    run --kernel clblast --n "$n" --csv "$OUT/$f"
  done
  stop_clocks
}

exp_ts() {  # Kernel 2 tile-size sweep
  local f=exp1_tiled_ts.csv
  begin ts $f
  for n in $GEMM_N; do
    for ts in 8 16 32; do run --kernel gemm_tiled --n "$n" --opts "-DTS=$ts" --registers --csv "$OUT/$f"; done
  done
  stop_clocks
}

exp_coalescing() {  # Experiment 2: naive vs naive_bad at three local sizes
  local f=exp2_coalescing.csv
  begin coalescing $f
  for n in $BAD_N; do
    for loc in 8x8 16x16 32x8; do
      run --kernel gemm_naive --n "$n" --local $loc --csv "$OUT/$f"
      # The uncoalesced kernel is the one most likely to exceed Windows' ~2 s TDR limit; at
      # N = 4096 it stays well under it on this GPU (fewer reps keep the sweep short).
      REPS=5 run --kernel gemm_naive_bad --n "$n" --local $loc --csv "$OUT/$f"
    done
  done
  stop_clocks
}

exp_ownership() {  # Kernel 3: strided vs contiguous ownership of the work-item's block of C
  local f=exp3_ownership.csv
  begin ownership $f
  for n in 2048 4096; do
    [ "$QUICK" = 1 ] && n=129
    for cfg in "-DTSM=64 -DTSN=64 -DTSK=16 -DWPTM=4 -DWPTN=4" "$BEST_REG"; do
      run --kernel gemm_reg --n "$n" --opts "$cfg" --registers --csv "$OUT/$f"
      run --kernel gemm_reg --n "$n" --opts "$cfg -DCONTIG=1" --registers --csv "$OUT/$f"
    done
    [ "$QUICK" = 1 ] && break
  done
  stop_clocks
}

exp_softmax() {  # Experiment 4: softmax variants vs row length
  local f=exp4_softmax.csv
  begin softmax $f
  for c in $SM_COLS; do
    run --kernel softmax_naive --rows $SM_ROWS --cols "$c" --csv "$OUT/$f"
    for k in softmax_wg softmax_online softmax_cached; do
      run --kernel $k --rows $SM_ROWS --cols "$c" --opts "-DWG=256" --registers --csv "$OUT/$f"
    done
  done
  stop_clocks
}

exp_softmax_wg() {  # Experiment 4b: work-group size
  local f=exp4_softmax_wg.csv
  begin softmax_wg $f
  for c in $WG_COLS; do
    for wg in 64 128 256 512 1024; do
      for k in softmax_wg softmax_online; do
        run --kernel $k --rows $SM_ROWS --cols "$c" --opts "-DWG=$wg" --csv "$OUT/$f"
      done
    done
  done
  stop_clocks
}

exp_layernorm() {
  local f=exp4_layernorm.csv
  begin layernorm $f
  for c in $LN_COLS; do
    run --kernel layernorm --rows $SM_ROWS --cols "$c" --opts "-DWG=256" --csv "$OUT/$f"
  done
  stop_clocks
}

exp_cpu_gpu() {  # Experiment 5, GPU side: kernel time plus host<->device copies
  local f=exp5_gpu.csv
  begin cpu_gpu $f
  for n in $CPU_GPU_N; do
    run --kernel gemm_tiled --n "$n" --opts "-DTS=16" --csv "$OUT/$f"
    run --kernel gemm_reg --n "$n" --opts "$BEST_REG" --csv "$OUT/$f"
  done
  stop_clocks
}

exp_cpu() {  # Experiment 5, CPU side: the Matmul project's best kernel on all threads
  if [ -z "${CPU_BENCH:-}" ]; then echo "== cpu: set CPU_BENCH to the Matmul bench (skipped)"; return; fi
  local f=exp5_cpu.csv threads
  threads=$(nproc 2> /dev/null || echo "${NUMBER_OF_PROCESSORS:-8}")
  echo "== cpu -> $OUT/$f"
  rm -f "$OUT/$f"
  for n in $CPU_GPU_N; do
    "$CPU_BENCH" --kernel simd --n "$n" --tile 128 --threads "$threads" --csv "$OUT/$f"
  done
}

exp_attention() {  # Experiment 7: one attention head, unfused vs fused
  local f=exp7_attention.csv
  begin attention $f
  for l in $ATT_L; do
    run --kernel attn_unfused --l "$l" --d 64 --csv "$OUT/$f"
    run --kernel attn_fused --l "$l" --d 64 --csv "$OUT/$f"
  done
  stop_clocks
}

ALL="ladder ts coalescing ownership softmax softmax_wg layernorm cpu_gpu cpu attention"
for e in ${*:-$ALL}; do
  case $e in
    ladder | ts | coalescing | ownership | softmax | softmax_wg | layernorm | cpu_gpu | cpu | attention) "exp_$e" ;;
    *) echo "unknown experiment: $e (choose from: $ALL)" >&2; exit 2 ;;
  esac
done
"$BENCH" --devices > "$OUT/devices.txt" || true
echo "done"
