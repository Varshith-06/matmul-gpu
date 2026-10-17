#!/usr/bin/env python3
"""What AMD's compiler says about every kernel-3 configuration in the HIP port.

Compiles hip/gemm_hip.cpp for one GPU target with -Rpass-analysis=kernel-resource-usage (one report
per kernel: VGPRs, SGPRs, scratch, LDS, occupancy in waves per SIMD) and --save-temps (the ISA).
Writes results/hip/hip_resources.csv, and for each configuration given with --isa, the kernel's
ISA plus instruction counts of its inner loop.

    python3 scripts/hip_resources.py [--arch gfx1103] [--wave64] [--isa 64,64,16,4,4 ...] [--out results/hip]
"""

import argparse
import csv
import re
import subprocess
import sys
import tempfile
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FIELDS = {  # remark label -> CSV column
    "TotalSGPRs": "sgprs", "VGPRs": "vgprs", "AGPRs": "agprs", "ScratchSize [bytes/lane]": "scratch_bytes",
    "Occupancy [waves/SIMD]": "waves_per_simd", "SGPRs Spill": "sgpr_spill", "VGPRs Spill": "vgpr_spill",
    "LDS Size [bytes/block]": "lds_bytes",
}
KEY = re.compile(r"gemm_reg<(\d+), (\d+), (\d+), (\d+), (\d+), (true|false)>")


def demangle(names):
    out = subprocess.run(["c++filt"], input="\n".join(names), capture_output=True, text=True, check=True)
    return out.stdout.splitlines()


def compile_with_remarks(arch, wave64, tmp):
    hipcc = "/opt/rocm/bin/hipcc"
    cmd = [hipcc, "-std=c++17", "-O3", f"--offload-arch={arch}", "--offload-device-only", "-c",
           str(ROOT / "hip" / "gemm_hip.cpp"), "-Rpass-analysis=kernel-resource-usage", "--save-temps",
           "-o", str(tmp / "gemm_hip.o")] + (["-mwavefrontsize64"] if wave64 else [])
    r = subprocess.run(cmd, capture_output=True, text=True, cwd=tmp)
    if r.returncode:
        raise SystemExit(r.stderr)
    return r.stderr


def parse_remarks(log):
    records, cur = [], None
    for line in log.splitlines():
        m = re.search(r"remark: .*?:\d+:\d+: +(.+?): (.+?)(?: \[-Rpass-analysis=[^\]]*\])?$", line)
        if not m:
            continue
        label, value = m.group(1).strip(), m.group(2).strip()
        if label == "Function Name":
            cur = {"mangled": value}
            records.append(cur)
        elif cur is not None and label in FIELDS:
            cur[FIELDS[label]] = value
    for rec, name in zip(records, demangle([r["mangled"] for r in records])):
        rec["name"] = name
    rows = []
    for rec in records:
        k = KEY.search(rec["name"])
        if not k:
            continue  # copy/fma kernels live in bench_hip.cpp, not here
        row = dict(zip(["tsm", "tsn", "tsk", "wptm", "wptn"], map(int, k.groups()[:5])))
        row["contig"] = int(k.group(6) == "true")
        row["threads"] = (row["tsm"] // row["wptm"]) * (row["tsn"] // row["wptn"])
        row.update({c: rec.get(c, "") for c in FIELDS.values()})
        row["mangled"] = rec["mangled"]
        rows.append(row)
    return sorted(rows, key=lambda r: (r["tsm"], r["tsn"], r["tsk"], r["wptm"], r["wptn"], r["contig"]))


def kernel_isa(asm, mangled):
    start = asm.index(f"\n{mangled}:") + 1  # the label line ends with a "; @name" comment
    end = asm.index(".Lfunc_end", start)
    return asm[start:end]


def loop_counts(isa):
    """Instruction counts of the kernel's main loop: of all backward branches, the loop body with the
    most FMAs (the k loop over one tile), shortest first on ties."""
    lines = isa.splitlines()
    labels = {l.strip().split(":")[0]: i for i, l in enumerate(lines) if re.match(r"^\.LBB\S+:", l.strip())}
    fma = re.compile(r"v_(dual_)?fmac?_f32|:: v_dual_fmac")
    best, key = None, None
    for i, l in enumerate(lines):
        m = re.match(r"\s*s_c?branch\w*\s+(\.LBB\S+)", l)
        if m and m.group(1) in labels and labels[m.group(1)] < i:
            body = lines[labels[m.group(1)]:i + 1]
            k = (sum(bool(fma.search(b)) for b in body), -len(body))
            if key is None or k > key:
                best, key = body, k
    ops = Counter()
    for l in best or []:
        t = l.strip()
        if not t or t.startswith((".", ";")):
            continue
        ops[t.split()[0]] += 1
        if " :: " in t:  # a VOPD pair counts both halves
            ops[t.split(" :: ")[1].split()[0]] += 1
    return ops


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--arch", default="gfx1103")
    ap.add_argument("--wave64", action="store_true", help="compile with -mwavefrontsize64")
    ap.add_argument("--isa", nargs="*", default=[], help="TSM,TSN,TSK,WPTM,WPTN[,contig] to dump")
    ap.add_argument("--out", default=str(ROOT / "results" / "hip"))
    args = ap.parse_args()
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory() as t:
        tmp = Path(t)
        log = compile_with_remarks(args.arch, args.wave64, tmp)
        suffix = "_wave64" if args.wave64 else ""
        rows = parse_remarks(log)
        cols = ["tsm", "tsn", "tsk", "wptm", "wptn", "contig", "threads"] + list(FIELDS.values())
        path = out / f"hip_resources{suffix}.csv"
        with open(path, "w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=["arch", "wave"] + cols)
            w.writeheader()
            for r in rows:
                w.writerow({"arch": args.arch, "wave": 64 if args.wave64 else 32, **{c: r[c] for c in cols}})
        print(f"wrote {path} ({len(rows)} kernels)", file=sys.stderr)

        asm_files = list(tmp.glob(f"*{args.arch}*.s"))
        if args.isa and not asm_files:
            raise SystemExit("no ISA file from --save-temps")
        asm = asm_files[0].read_text() if asm_files else ""
        for spec in args.isa:
            f = spec.split(",")
            want = tuple(map(int, f[:5])) + (int(len(f) == 6),)
            row = next(r for r in rows if (r["tsm"], r["tsn"], r["tsk"], r["wptm"], r["wptn"], r["contig"]) == want)
            isa = kernel_isa(asm, row["mangled"])
            name = "gemm_reg_{}x{}_k{}_{}x{}{}".format(*want[:5], "_contig" if want[5] else "")
            (out / "isa").mkdir(exist_ok=True)
            (out / "isa" / f"{name}_{args.arch}{suffix}.s").write_text(isa)
            ops = loop_counts(isa)
            print(f"{name}: main loop, {sum(ops.values())} operations (VOPD pairs count twice)")
            for op, n in ops.most_common():
                print(f"  {n:4d} {op}")


if __name__ == "__main__":
    main()
