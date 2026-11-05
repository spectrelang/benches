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

# Dynamic linking matches the other benchmark binaries. The 32-byte-aligned
# buffers in the Spectre source let the backend emit AVX2-width vector loops.
"$SPECTRE" core_vector.sx -release -alt -native -unroll -dynamic -o core-vector-spectre
zig build-exe core_vector.zig -OReleaseFast -mcpu=native -femit-bin=core-vector-zig
ldc2 -O3 -release -boundscheck=off -mcpu=native core_vector.d -of=core-vector-d
rustc -C opt-level=3 -C target-cpu=native -C codegen-units=1 -C lto=fat core_vector.rs -o core-vector-rust
clang++ -O3 -march=native -std=c++17 core_vector.cpp -o core-vector-cpp

for bin in core-vector-spectre core-vector-zig core-vector-d core-vector-rust core-vector-cpp; do
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
	"./core-vector-spectre" \
	"./core-vector-zig" \
	"./core-vector-d" \
	"./core-vector-rust" \
	"./core-vector-cpp"
