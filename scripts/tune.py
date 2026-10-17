#!/usr/bin/env python3
"""Kernel-3 tuning sweep (experiment 3).

Runs bench over the grid TSM = TSN in {32, 64, 128}, TSK in {8, 16, 32}, WPTM = WPTN in {2, 4, 8}
at N = 2048 and 4096, with register and spill counts from ptxas. bench itself rejects points that
break the kernel's divisibility rules or the device's limits (exit code 3); they are skipped.
Writes results/exp3_tuning.csv and the best configuration at the largest N to results/best_reg.txt,
which scripts/sweep.sh then uses for the ladder.

    python scripts/tune.py [--device "RTX 4060"] [--n 2048 4096] [--reps 20] [--quick] [--no-clocks]
"""

import argparse
import csv
import itertools
import shutil
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CLOCK_FIELDS = "timestamp,utilization.gpu,clocks.sm,clocks.mem,temperature.gpu,power.draw,clocks_event_reasons.active"


def default_bench():
    for name in ("bench.exe", "bench"):
        p = ROOT / "build" / name
        if p.exists():
            return str(p)
    return str(ROOT / "build" / "bench")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--bench", default=default_bench())
    ap.add_argument("--device", default="RTX 4060")
    ap.add_argument("--n", type=int, nargs="+", default=[2048, 4096])
    ap.add_argument("--reps", type=int, default=20)
    ap.add_argument("--cool", type=float, default=1.0, help="seconds of cool-down between points")
    ap.add_argument("--out", default=str(ROOT / "results"))
    ap.add_argument("--quick", action="store_true", help="small N, 2 reps, any device (CI smoke test)")
    ap.add_argument("--no-clocks", action="store_true",
                    help="don't log nvidia-smi clocks (for a non-NVIDIA device)")
    args = ap.parse_args()
    if args.quick:
        args.n, args.reps, args.cool, args.device = [129], 2, 0.0, ""

    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    csv_path = out / "exp3_tuning.csv"
    if csv_path.exists():
        csv_path.unlink()

    clocks = None
    if not args.quick and not args.no_clocks and shutil.which("nvidia-smi"):  # as log_clocks.sh
        log = open(out / "clocks_tuning.csv", "w")
        clocks = subprocess.Popen(["nvidia-smi", "--query-gpu=" + CLOCK_FIELDS, "--format=csv", "-lms", "500"],
                                  stdout=log)

    ran = skipped = 0
    try:
        for n in args.n:
            for ts, tsk, wpt in itertools.product([32, 64, 128], [8, 16, 32], [2, 4, 8]):
                opts = f"-DTSM={ts} -DTSN={ts} -DTSK={tsk} -DWPTM={wpt} -DWPTN={wpt}"
                cmd = [args.bench, "--device", args.device, "--kernel", "gemm_reg", "--n", str(n),
                       "--opts", opts, "--reps", str(args.reps), "--registers", "--csv", str(csv_path)]
                rc = subprocess.run(cmd).returncode
                if rc == 3:
                    skipped += 1
                    continue
                if rc != 0:
                    sys.exit(f"tune: bench failed ({rc}) for N={n} {opts}")
                ran += 1
                time.sleep(args.cool)
    finally:
        if clocks:
            clocks.terminate()

    with open(csv_path, newline="") as f:
        rows = [r for r in csv.DictReader(f) if int(r["n"]) == max(args.n)]
    best = max(rows, key=lambda r: float(r["gflops"]))
    (out / "best_reg.txt").write_text(best["opts"] + "\n")
    print(f"tune: {ran} points run, {skipped} invalid skipped")
    print(f"tune: best at N={best['n']}: {best['opts']} -> {float(best['gflops']):.0f} GFLOPS, "
          f"{best['registers']} registers")


if __name__ == "__main__":
    main()
