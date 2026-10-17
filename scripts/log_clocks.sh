#!/usr/bin/env bash
# Logs the GPU's SM and memory clocks, temperature, power draw and clock-event (throttle) reasons
# every 500 ms until killed. Run it alongside every sweep: a number is only meaningful next to the
# clock it ran at.
#   scripts/log_clocks.sh [results/clocks.csv]
# Works in Git Bash on Windows (nvidia-smi ships with the driver) and on Linux.
set -euo pipefail
OUT=${1:-results/clocks.csv}
mkdir -p "$(dirname "$OUT")"
# clocks_event_reasons.active is the current name of clocks_throttle_reasons.active.
exec nvidia-smi \
  --query-gpu=timestamp,utilization.gpu,clocks.sm,clocks.mem,temperature.gpu,power.draw,clocks_event_reasons.active \
  --format=csv -lms 500 > "$OUT"
