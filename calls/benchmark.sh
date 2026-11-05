#!/usr/bin/env bash
set -euo pipefail

# Zig: v0.17.0
# LDC2: v1.41.0
# Rust: v1.94.0
# Clang++: Apple clang 16
# Spectre: canary build (see ../spectre)

if [[ -z "${SPECTRE:-}" ]]; then
	if [[ -x "../../spectre/spectre-dev" ]]; then
		SPECTRE="../../spectre/spectre-dev"
	else
		SPECTRE="spectre"
	fi
fi

"$SPECTRE" calls.sx --release -o calls-spectre --alt
zig build-exe calls.zig -OReleaseFast -femit-bin=calls-zig
ldc2 -O3 -release -boundscheck=off calls.d -of=calls-d
rustc -O calls.rs -o calls-rust
clang++ -O3 -std=c++17 calls.cpp -o calls-cpp

for bin in calls-spectre calls-zig calls-d calls-rust calls-cpp; do
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
	"./calls-spectre" \
	"./calls-zig" \
	"./calls-d" \
	"./calls-rust" \
	"./calls-cpp"
