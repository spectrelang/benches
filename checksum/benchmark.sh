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

"$SPECTRE" checksum.sx --release -o checksum-spectre --alt
zig build-exe checksum.zig -OReleaseFast -femit-bin=checksum-zig
ldc2 -O3 -release -boundscheck=off checksum.d -of=checksum-d
rustc -O checksum.rs -o checksum-rust
clang++ -O3 -std=c++17 checksum.cpp -o checksum-cpp

for bin in checksum-spectre checksum-zig checksum-d checksum-rust checksum-cpp; do
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
	"./checksum-spectre" \
	"./checksum-zig" \
	"./checksum-d" \
	"./checksum-rust" \
	"./checksum-cpp"
