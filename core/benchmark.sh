#!/usr/bin/env bash
set -euo pipefail

# Zig: v0.17.0
# LDC2: v1.36.0
# Rust: v1.93.1
# Clang++: v18.1.3
# Spectre: canary build (v0.0.14)

if [[ -z "${SPECTRE:-}" ]]; then
	if [[ -x "../../spectre/spectre-dev" ]]; then
		SPECTRE="../../spectre/spectre-dev"
	else
		SPECTRE="spectre"
	fi
fi

# Spectre: fallback backend with the strongest optimization flags.
"$SPECTRE" core.sx --release --alt --native --unroll -o core-spectre
zig build-exe core.zig -OReleaseFast -mcpu=native -femit-bin=core-zig
ldc2 -O3 -release -boundscheck=off -mcpu=native core_bench.d -of=core-d
rustc -C opt-level=3 -C target-cpu=native -C codegen-units=1 -C lto=fat -C panic=abort core.rs -o core-rust
clang++ -O3 -march=native -flto -std=c++17 core.cpp -o core-cpp

for bin in core-spectre core-zig core-d core-rust core-cpp; do
	if [[ ! -x "$bin" ]]; then
		echo "Missing executable: $bin" >&2
		exit 1
	fi
done

hyperfine \
	--warmup 3 \
	--runs 15 \
	--sort command \
	--export-json benchmark-results.json \
	--export-markdown benchmark-results.md \
	"./core-spectre" \
	"./core-zig" \
	"./core-d" \
	"./core-rust" \
	"./core-cpp"
