#!/usr/bin/env python3
"""PyTorch on CUDA (cuBLAS) as the hardware's practical FP32 ceiling for GEMM and softmax.

This is CUDA, not OpenCL: it is labelled as a ceiling, not as a competitor. TF32 tensor cores are
disabled so the GEMM is true FP32, like the OpenCL kernels. Rows are appended to the same CSVs and
in the same format as bench, so one plotting script reads both.

    python reference/torch_ref.py [--gemm-n 256 ... 4096] [--softmax-cols 128 ... 32768] [--out results]
"""

import argparse
import csv
from pathlib import Path

import torch

HEADER = ("gpu,driver,kernel,n,rows,cols,opts,local,reps,median_ms,min_ms,gflops,gbps,h2d_ms,d2h_ms,"
          "max_rel_err,registers,spill_bytes").split(",")


def time_ms(fn, reps):
    for _ in range(3):  # warm-up
        fn()
    torch.cuda.synchronize()
    start, end = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    times = []
    for _ in range(reps):
        start.record()
        fn()
        end.record()
        torch.cuda.synchronize()
        times.append(start.elapsed_time(end))
    times.sort()
    m = len(times) // 2
    med = times[m] if len(times) % 2 else 0.5 * (times[m - 1] + times[m])
    return med, times[0]


def append(path, row):
    new = not path.exists() or path.stat().st_size == 0
    with open(path, "a", newline="") as f:
        w = csv.DictWriter(f, fieldnames=HEADER)
        if new:
            w.writeheader()
        w.writerow({k: row.get(k, "") for k in HEADER})


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--gemm-n", type=int, nargs="*", default=[256, 512, 768, 1024, 1536, 2048, 3072, 4096])
    ap.add_argument("--softmax-rows", type=int, default=4096)
    ap.add_argument("--softmax-cols", type=int, nargs="*",
                    default=[128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768])
    ap.add_argument("--reps", type=int, default=20)
    ap.add_argument("--out", default=str(Path(__file__).resolve().parent.parent / "results"))
    args = ap.parse_args()

    if not torch.cuda.is_available():
        raise SystemExit("torch_ref: CUDA is not available")
    torch.backends.cuda.matmul.allow_tf32 = False  # true FP32, not TF32 tensor cores
    torch.backends.cudnn.allow_tf32 = False
    gpu = torch.cuda.get_device_name(0)
    driver = f"torch {torch.__version__} / CUDA {torch.version.cuda}"
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)
    g = torch.Generator(device="cuda").manual_seed(42)

    for n in args.gemm_n:
        a = torch.rand(n, n, device="cuda", generator=g) * 2 - 1
        b = torch.rand(n, n, device="cuda", generator=g) * 2 - 1
        c = torch.empty(n, n, device="cuda")
        med, best = time_ms(lambda: torch.matmul(a, b, out=c), args.reps)
        ref = (a.double() @ b.double()).float() if n <= 2048 else None
        err = ((c - ref).abs().max() / ref.abs().max()).item() if ref is not None else ""
        gflops = 2 * n**3 / (med * 1e-3) / 1e9
        append(out / "exp1_ladder.csv", dict(gpu=gpu, driver=driver, kernel="torch_cublas", n=n,
                                             reps=args.reps, median_ms=f"{med:.6f}", min_ms=f"{best:.6f}",
                                             gflops=f"{gflops:.2f}", max_rel_err=f"{err:.3e}" if err != "" else ""))
        print(f"torch_cublas   n={n:<5} median={med:.4f} ms  {gflops:8.1f} GFLOPS")

    r = args.softmax_rows
    for cols in args.softmax_cols:
        x = torch.rand(r, cols, device="cuda", generator=g) * 2 - 1
        med, best = time_ms(lambda: torch.softmax(x, dim=1), args.reps)
        gbps = 2 * r * cols * 4 / (med * 1e-3) / 1e9
        append(out / "exp4_softmax.csv", dict(gpu=gpu, driver=driver, kernel="torch_softmax", rows=r, cols=cols,
                                              reps=args.reps, median_ms=f"{med:.6f}", min_ms=f"{best:.6f}",
                                              gbps=f"{gbps:.2f}"))
        print(f"torch_softmax  rows={r} cols={cols:<6} median={med:.4f} ms  {gbps:7.1f} GB/s")


if __name__ == "__main__":
    main()
