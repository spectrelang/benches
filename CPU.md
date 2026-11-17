# Spectre CPU Benchmarks

These benchmarks compare Spectre's (v0.0.17) implicit compile-time folding
against equivalent C, C++, Zig, Goose and Crystal programs.

Unlike the CTE benchmarks, no program asks the compiler to evaluate anything.
There is no `pure`, `@static`, `constexpr`, `comptime`, container-level constant
evaluation, or precomputed constant in any of the six variants. Every program
calls the same ordinary functions with the same constant arguments inside the
same hot loop. Any folding that happens is the compiler's own decision.

All six programs are short, CPU-bound kernels. Every variant prints the same
checksum; the checksums were verified across all six languages before timing.

## System

- CPU: AMD Ryzen 5 5600X-class, 6 cores / 12 threads (detected as AMD Ryzen 5 5600), 3.5–4.4 GHz
- L3 cache: 32 MiB
- RAM: 32 GB (31 GiB usable)
- OS: Linux 6.14.0-37-generic (Ubuntu 24.04)
- Spectre: 0.0.17 (e373d1f), UQBE backend, `-release -native`
- C: GCC 13.3.0, `-O3 -march=native`
- C++: GCC 13.3.0, `-O3 -march=native -std=c++20`
- Zig: 0.17.0, `ReleaseFast`, `-mcpu=native`
- Goose: runtime `4d3da949e563`, `goose build -O2`
- Crystal: 1.18.2 (LLVM 18.1.8), `--release --mcpu native`
- Harness: hyperfine 1.18.0, 3 warmups, 10 runs, `--shell=none`

## Results

Mean wall-clock times. Lower is better. "vs Spectre" is the speedup of Spectre
over that implementation; values below 1.00× mean Spectre is slower.

| Benchmark        |     Spectre |                   C |              C++ |             Zig |            Goose |         Crystal |
| ---------------- | ----------: | ------------------: | ---------------: | --------------: | ---------------: | --------------: |
| `fold_const`     | **4.95 ms** |    139.9 ms (28.3×) | 140.1 ms (28.3×) | 5.10 ms (1.03×) | 144.2 ms (29.2×) | 6.04 ms (1.22×) |
| `fold_expr`      | **7.19 ms** |     7.68 ms (1.07×) |  7.60 ms (1.06×) | 7.49 ms (1.04×) |  7.60 ms (1.06×) | 8.28 ms (1.15×) |
| `fold_loop`      |  **185 µs** |     10.1 ms (54.5×) |  10.2 ms (55.3×) | 13.9 ms (75.4×) |  10.1 ms (54.3×) | 16.0 ms (86.7×) |
| `fold_recursive` | **5.10 ms** |     5.23 ms (1.03×) |  5.27 ms (1.03×) | 5.14 ms (1.01×) |  5.32 ms (1.04×) | 6.12 ms (1.20×) |
| `table_hash`     |     5.30 ms | **4.78 ms** (0.90×) |  4.88 ms (0.92×) | 5.42 ms (1.02×) |  5.56 ms (1.05×) | 6.24 ms (1.18×) |

Spectre is fastest in four of the five benchmarks. The large gains are in
`fold_const` and `fold_loop`, where a constant-argument call is replaced by its
value without any annotation on the function. `fold_expr` and `fold_recursive`
are dominated by the hot loop, so the implementations land within a few percent
of one another apart from Crystal, whose runtime startup adds about 1 ms.
`table_hash` is the one kernel where Spectre is not fastest: every
implementation builds the table once at startup, and C
and C++ are about 10% ahead.

Spectre's own report of implicit folding, obtained with `-loud`:

```text
fold_const      CTE: 2 folded call(s)
fold_expr       CTE: 1 folded call(s)
fold_loop       CTE: 1 folded call(s)
fold_recursive  CTE: 0 folded call(s)
table_hash      CTE: 0 folded call(s)
```

## Reproducing

```bash
./cpu-v0.0.17/run.sh
```

Hyperfine JSON is written to `cpu-v0.0.17/results/`. Source files live in:

```text
cpu-v0.0.17/spectre/
cpu-v0.0.17/c/
cpu-v0.0.17/cpp/
cpu-v0.0.17/zig/
cpu-v0.0.17/goose/
cpu-v0.0.17/crystal/
```
