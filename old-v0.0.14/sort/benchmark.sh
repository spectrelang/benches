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

"$SPECTRE" sort.sx -release -o sort-spectre -alt
zig build-exe sort.zig -OReleaseFast -femit-bin=sort-zig
ldc2 -O3 -release -boundscheck=off sort.d -of=sort-d
rustc -O sort.rs -o sort-rust
clang++ -O3 -std=c++17 sort.cpp -o sort-cpp

for bin in sort-spectre sort-zig sort-d sort-rust sort-cpp; do
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
	"./sort-spectre" \
	"./sort-zig" \
	"./sort-d" \
	"./sort-rust" \
	"./sort-cpp"
