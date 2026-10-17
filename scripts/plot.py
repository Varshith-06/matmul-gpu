#!/usr/bin/env python3
"""Turn the CSVs from sweep.sh, tune.py and torch_ref.py into the README's plots and tables.

    python scripts/plot.py [--results results]

Peak GFLOPS is computed from the median SM clock logged while each experiment ran (3,072 FP32
lanes x 2 FLOPs per FMA x clock), not from the spec sheet.
"""

import argparse
import re
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import numpy as np  # noqa: E402
import pandas as pd  # noqa: E402

LANES = 3072  # RTX 4060 Laptop: 24 SMs x 128 FP32 lanes
BANDWIDTH = 256.0  # GB/s: 128-bit GDDR6 at 16 Gbps
SOFTMAX_FLOPS = 5  # per element: max, subtract, exp, add, multiply (exp counted as one)

LADDER = [("gemm_naive", "naive"), ("gemm_tiled", "tiled (local memory)"),
          ("gemm_reg", "register-blocked"), ("clblast", "CLBlast (ref)"),
          ("torch_cublas", "PyTorch / cuBLAS (CUDA ceiling)")]
SOFTMAX = [("softmax_naive", "naive (row per work-item)"), ("softmax_wg", "work-group, 3 passes"),
           ("softmax_online", "online, 2 passes"), ("softmax_cached", "row cached in local memory"),
           ("torch_softmax", "PyTorch (CUDA ceiling)")]


def load(path):
    if not path.exists():
        return None
    df = pd.read_csv(path)
    key = [c for c in ["kernel", "n", "rows", "cols", "opts", "local"] if c in df.columns]
    return df.drop_duplicates(subset=key, keep="last")  # a re-run replaces older rows


def save(fig, path):
    fig.tight_layout()
    fig.savefig(path, dpi=150)
    plt.close(fig)
    print("wrote", path)


def clock_stats(results, name):
    """Median SM clock (MHz) and temperature while the GPU was busy during one experiment."""
    path = results / f"clocks_{name}.csv"
    if not path.exists():
        return None
    df = pd.read_csv(path, skipinitialspace=True)
    df.columns = [c.split(" [")[0].strip() for c in df.columns]

    def num(col):
        return pd.to_numeric(df[col].astype(str).str.extract(r"([-0-9.]+)")[0], errors="coerce")

    sm, temp = num("clocks.current.sm"), num("temperature.gpu")
    busy = num("utilization.gpu") >= 50 if "utilization.gpu" in df.columns else sm >= 0.5 * sm.max()
    if busy.sum() == 0:
        return None
    return {"sm": float(sm[busy].median()), "temp": float(temp[busy].median()),
            "temp_max": float(temp[busy].max()), "sm_min": float(sm[busy].min())}


def peak_gflops(clock_mhz):
    return LANES * 2 * clock_mhz / 1000.0


def ladder(df, clocks, out):
    fig, ax = plt.subplots(figsize=(7.5, 4.8))
    for kernel, name in LADDER:
        g = df[df.kernel == kernel].sort_values("n")
        if len(g):
            ax.plot(g.n, g.gflops, marker="o", label=name, linestyle="--" if kernel in ("clblast", "torch_cublas") else "-")
    if clocks:
        p = peak_gflops(clocks["sm"])
        ax.axhline(p, color="k", lw=1, ls=":")
        ax.text(df.n.min(), p * 1.05, f"FP32 peak at the measured {clocks['sm']:.0f} MHz: {p:,.0f} GFLOPS", fontsize=8)
    ax.set_yscale("log")
    ax.set(xlabel="N (square, FP32)", ylabel="GFLOPS (median)", title="GEMM ladder, RTX 4060 Laptop GPU")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(fontsize=8, loc="lower right")
    save(fig, out / "exp1_ladder.png")


def tiled_ts(df, out):
    fig, ax = plt.subplots(figsize=(6.5, 4))
    df = df.assign(ts=df.opts.str.extract(r"TS=(\d+)")[0].astype(int))
    for ts, g in df.groupby("ts"):
        g = g.sort_values("n")
        ax.plot(g.n, g.gflops, marker="o", label=f"TS = {ts}")
    ax.set(xlabel="N", ylabel="GFLOPS (median)", title="Kernel 2: tile size")
    ax.grid(True, alpha=0.3)
    ax.legend()
    save(fig, out / "exp1_tiled_ts.png")


def coalescing(df, out):
    df = df.copy()
    groups = sorted(df.n.unique())
    locals_ = ["8x8", "16x16", "32x8"]
    fig, ax = plt.subplots(figsize=(8, 4.2))
    width = 0.13
    x = np.arange(len(groups))
    i = 0
    for kernel, hatch in [("gemm_naive", None), ("gemm_naive_bad", "//")]:
        for loc in locals_:
            vals = [df[(df.kernel == kernel) & (df.n == n) & (df.local == loc)].gflops.max() for n in groups]
            ax.bar(x + (i - 2.5) * width, vals, width, hatch=hatch,
                   label=f"{'coalesced' if kernel == 'gemm_naive' else 'uncoalesced'} {loc}")
            i += 1
    ax.set_xticks(x, [f"N = {n}" for n in groups])
    ax.set(ylabel="GFLOPS (median)", title="Naive GEMM: dimension 0 = column (coalesced) vs row")
    ax.legend(fontsize=7, ncol=2)
    ax.grid(True, axis="y", alpha=0.3)
    save(fig, out / "exp2_coalescing.png")


def tuning(df, out):
    df = df.copy()
    for k in ["TSM", "TSK", "WPTM"]:
        df[k] = df.opts.str.extract(rf"-D{k}=(\d+)")[0].astype(int)
    ns = sorted(df.n.unique())
    tsks = sorted(df.TSK.unique())
    tiles, wpts = [32, 64, 128], [2, 4, 8]
    fig, axes = plt.subplots(len(ns), len(tsks), figsize=(3.6 * len(tsks), 3.2 * len(ns)), squeeze=False)
    vmax = df.gflops.max()
    for r, n in enumerate(ns):
        for c, tsk in enumerate(tsks):
            ax = axes[r][c]
            grid = np.full((len(tiles), len(wpts)), np.nan)
            regs = [["" for _ in wpts] for _ in tiles]
            for i, t in enumerate(tiles):
                for j, w in enumerate(wpts):
                    g = df[(df.n == n) & (df.TSK == tsk) & (df.TSM == t) & (df.WPTM == w)]
                    if len(g):
                        grid[i, j] = g.gflops.iloc[0]
                        reg = g.registers.iloc[0]
                        sp = g.spill_bytes.iloc[0] if "spill_bytes" in g else 0
                        regs[i][j] = (f"{int(reg)} regs" if pd.notna(reg) else "") + (" spill" if pd.notna(sp) and sp > 0 else "")
            im = ax.imshow(grid, cmap="viridis", vmin=0, vmax=vmax, origin="lower")
            for i in range(len(tiles)):
                for j in range(len(wpts)):
                    if np.isnan(grid[i, j]):
                        ax.text(j, i, "invalid", ha="center", va="center", fontsize=7, color="0.5")
                    else:
                        color = "k" if grid[i, j] > 0.6 * vmax else "w"
                        ax.text(j, i, f"{grid[i, j]:.0f}\n{regs[i][j]}", ha="center", va="center", fontsize=7, color=color)
            ax.set_xticks(range(len(wpts)), [f"{w}x{w}" for w in wpts])
            ax.set_yticks(range(len(tiles)), [str(t) for t in tiles])
            ax.set(xlabel="work per thread (WPTM x WPTN)", ylabel="tile TSM = TSN", title=f"N = {n}, TSK = {tsk}")
    fig.colorbar(im, ax=axes, shrink=0.6, label="GFLOPS")
    fig.suptitle("Kernel 3 tuning (GFLOPS; ptxas registers per work-item)")
    fig.savefig(out / "exp3_tuning.png", dpi=150, bbox_inches="tight")
    plt.close(fig)
    print("wrote", out / "exp3_tuning.png")


def softmax(df, out):
    fig, ax = plt.subplots(figsize=(7, 4.5))
    for kernel, name in SOFTMAX:
        g = df[df.kernel == kernel].sort_values("cols")
        if len(g):
            ax.plot(g.cols, g.gbps, marker="o", label=name, linestyle="--" if kernel.startswith("torch") else "-")
    ax.axhline(BANDWIDTH, color="k", lw=1, ls=":")
    ax.text(df.cols.min(), BANDWIDTH * 1.04, "256 GB/s DRAM peak", fontsize=8)
    ax.set_xscale("log", base=2)
    ax.set(xlabel="row length C (R = 4096 rows)", ylabel="effective GB/s (8 bytes per element)",
           title="Softmax: effective bandwidth")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(fontsize=8)
    save(fig, out / "exp4_softmax.png")


def softmax_wg(df, out):
    df = df.assign(wg=df.opts.str.extract(r"WG=(\d+)")[0].astype(int))
    fig, ax = plt.subplots(figsize=(6.5, 4))
    for (kernel, cols), g in df.groupby(["kernel", "cols"]):
        g = g.sort_values("wg")
        ax.plot(g.wg, g.gbps, marker="o", label=f"{kernel.replace('softmax_', '')}, C = {cols}")
    ax.set_xscale("log", base=2)
    ax.set(xlabel="work-group size", ylabel="effective GB/s", title="Softmax: work-group size")
    ax.grid(True, alpha=0.3)
    ax.legend(fontsize=7)
    save(fig, out / "exp4_softmax_wg.png")


def cpu_gpu(gpu, cpu, out):
    gpu = gpu.assign(total=gpu.median_ms + gpu.h2d_ms + gpu.d2h_ms)
    best = gpu.loc[gpu.groupby("n").total.idxmin()].sort_values("n")
    kern = gpu.loc[gpu.groupby("n").median_ms.idxmin()].sort_values("n")
    fig, ax = plt.subplots(figsize=(7, 4.5))
    ax.plot(best.n, best.total, marker="o", label="GPU: kernel + host<->device copies")
    ax.plot(kern.n, kern.median_ms, marker="o", ls="--", label="GPU: kernel only")
    if cpu is not None:
        cpu = cpu.sort_values("n")
        ax.plot(cpu.n, cpu.median_s * 1e3, marker="s", label=f"CPU: Matmul simd, {int(cpu.threads.iloc[0])} threads")
    ax.set_xscale("log", base=2)
    ax.set_yscale("log")
    ax.set(xlabel="N", ylabel="time (ms, median)", title="CPU vs GPU GEMM on the same laptop")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(fontsize=8)
    save(fig, out / "exp5_cpu_gpu.png")

    fig, ax = plt.subplots(figsize=(6.5, 4))
    ax.plot(best.n, best.h2d_ms, marker="o", label="host -> device (A and B)")
    ax.plot(best.n, best.d2h_ms, marker="o", label="device -> host (C)")
    ax.plot(best.n, best.median_ms, marker="o", ls="--", label="kernel")
    ax.set_xscale("log", base=2)
    ax.set_yscale("log")
    ax.set(xlabel="N", ylabel="time (ms, median)", title="Transfer cost vs kernel time")
    ax.grid(True, which="both", alpha=0.3)
    ax.legend(fontsize=8)
    save(fig, out / "exp5_transfers.png")


def modeled_intensity(kernel, opts, n):
    """FLOPs per byte of global loads the kernel issues, ignoring caches."""
    if kernel in ("gemm_naive", "gemm_naive_bad"):
        return 0.25
    if kernel == "gemm_tiled":
        return int(re.search(r"TS=(\d+)", opts).group(1)) / 4
    if kernel == "gemm_reg":
        m = int(re.search(r"TSM=(\d+)", opts).group(1))
        nn = int(re.search(r"TSN=(\d+)", opts).group(1))
        return m * nn / (2 * (m + nn))
    if kernel in ("clblast", "torch_cublas"):
        return n / 6  # algorithmic minimum traffic: read A and B, write C once
    return {"softmax_naive": SOFTMAX_FLOPS / 16, "softmax_wg": SOFTMAX_FLOPS / 16,
            "softmax_online": SOFTMAX_FLOPS / 12, "softmax_cached": SOFTMAX_FLOPS / 8,
            "torch_softmax": SOFTMAX_FLOPS / 8}.get(kernel)


def roofline(ladder_df, soft_df, clocks, out):
    peak = peak_gflops(clocks["sm"] if clocks else 2250)
    fig, ax = plt.subplots(figsize=(7.5, 5))
    x = np.logspace(-2, 3.2, 200)
    ax.plot(x, np.minimum(peak, x * BANDWIDTH), "k-", lw=1)
    ridge = peak / BANDWIDTH
    ax.axvline(ridge, color="0.6", ls=":", lw=1)
    ax.text(ridge * 1.08, peak * 0.02, f"ridge {ridge:.0f} FLOPs/byte", fontsize=8, color="0.4")
    pts = []
    if ladder_df is not None:
        n = ladder_df.n.max()
        for _, r in ladder_df[ladder_df.n == n].iterrows():
            pts.append((r.kernel, modeled_intensity(r.kernel, str(r.opts), n), r.gflops))
    if soft_df is not None:
        c = 4096 if (soft_df.cols == 4096).any() else soft_df.cols.max()
        for _, r in soft_df[soft_df.cols == c].iterrows():
            ai = modeled_intensity(r.kernel, "", 0)
            if ai:
                pts.append((r.kernel, ai, SOFTMAX_FLOPS * r.rows * r.cols / (r.median_ms * 1e-3) / 1e9))
    for i, (name, ai, g) in enumerate(pts):
        ax.scatter(ai, g, s=30, zorder=3)
        dy = 4 if not name.startswith(("softmax", "torch_softmax")) else -14 + 9 * (i % 4)  # stagger close labels
        ax.annotate(name, (ai, g), textcoords="offset points", xytext=(6, dy), fontsize=7)
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set(xlabel="arithmetic intensity (FLOPs per byte of global loads issued)", ylabel="GFLOPS",
           title="Roofline: 256 GB/s, FP32 peak at the measured clock")
    ax.grid(True, which="both", alpha=0.3)
    save(fig, out / "exp6_roofline.png")


def attention(df, out):
    df = df.copy()
    df[["variant", "stage"]] = df.kernel.str.split("/", expand=True)
    stages = ["transpose", "qk", "scale", "softmax", "softmax_scaled", "pv"]
    colors = dict(zip(stages, plt.rcParams["axes.prop_cycle"].by_key()["color"]))
    ls = sorted(df.rows.unique())
    # One linear panel per L: stacked segments on a log axis would misstate their sizes.
    fig, axes = plt.subplots(1, len(ls), figsize=(2.4 * len(ls) + 1, 4.2), squeeze=False)
    used = set()
    for ax, L in zip(axes[0], ls):
        for x, variant in enumerate(["attn_unfused", "attn_fused"]):
            g = df[(df.rows == L) & (df.variant == variant)]
            bottom = 0.0
            for s_ in stages:
                v = g[g.stage == s_].median_ms
                if len(v):
                    ax.bar(x, v.iloc[0], bottom=bottom, color=colors[s_], width=0.6,
                           label=s_ if s_ not in used else None)
                    used.add(s_)
                    bottom += v.iloc[0]
            ax.text(x, bottom, f"{bottom:.2f}", ha="center", va="bottom", fontsize=7)
        ax.set_xticks([0, 1], ["unfused", "fused"])
        ax.set_title(f"L = {L}", fontsize=9)
        ax.grid(True, axis="y", alpha=0.3)
    axes[0][0].set_ylabel("time (ms, sum of per-kernel medians)")
    fig.legend(loc="center right", fontsize=8)
    fig.suptitle("One attention head (d = 64): time per kernel")
    fig.tight_layout(rect=(0, 0, 0.86, 1))
    fig.savefig(out / "exp7_attention.png", dpi=150)
    plt.close(fig)
    print("wrote", out / "exp7_attention.png")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--results", default=str(Path(__file__).resolve().parent.parent / "results"))
    args = ap.parse_args()
    res = Path(args.results)

    lad, ts, coal = load(res / "exp1_ladder.csv"), load(res / "exp1_tiled_ts.csv"), load(res / "exp2_coalescing.csv")
    tune, soft, swg = load(res / "exp3_tuning.csv"), load(res / "exp4_softmax.csv"), load(res / "exp4_softmax_wg.csv")
    gpu5, cpu5, att = load(res / "exp5_gpu.csv"), load(res / "exp5_cpu.csv"), load(res / "exp7_attention.csv")
    clocks = clock_stats(res, "ladder")

    summary = []
    for name in ["ladder", "ts", "coalescing", "tuning", "ownership", "softmax", "softmax_wg", "layernorm",
                 "cpu_gpu", "attention", "torch"]:
        c = clock_stats(res, name)
        if c:
            summary.append(f"| {name} | {c['sm']:.0f} | {c['sm_min']:.0f} | {peak_gflops(c['sm']):,.0f} | "
                           f"{c['temp']:.0f} | {c['temp_max']:.0f} |")
    if summary:
        text = ("| Experiment | Median SM clock (MHz) | Min (MHz) | Peak at median (GFLOPS) | Median temp (C) | Max temp (C) |\n"
                "|---|---:|---:|---:|---:|---:|\n" + "\n".join(summary) + "\n")
        (res / "clocks_summary.md").write_text(text)
        print("wrote", res / "clocks_summary.md")

    if lad is not None:
        ladder(lad, clocks, res)
    if ts is not None:
        tiled_ts(ts, res)
    if coal is not None:
        coalescing(coal, res)
    if tune is not None:
        tuning(tune, res)
    if soft is not None:
        softmax(soft, res)
    if swg is not None:
        softmax_wg(swg, res)
    if gpu5 is not None:
        cpu_gpu(gpu5, cpu5, res)
    if lad is not None or soft is not None:
        roofline(lad, soft, clocks, res)
    if att is not None:
        attention(att, res)


if __name__ == "__main__":
    main()
