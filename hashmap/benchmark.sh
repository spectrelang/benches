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

"$SPECTRE" hashmap.sx --release -o hashmap-spectre --alt
zig build-exe hashmap.zig -OReleaseFast -femit-bin=hashmap-zig
ldc2 -O3 -release -boundscheck=off hashmap.d -of=hashmap-d
rustc -O hashmap.rs -o hashmap-rust
clang++ -O3 -std=c++17 hashmap.cpp -o hashmap-cpp

for bin in hashmap-spectre hashmap-zig hashmap-d hashmap-rust hashmap-cpp; do
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
	"./hashmap-spectre" \
	"./hashmap-zig" \
	"./hashmap-d" \
	"./hashmap-rust" \
	"./hashmap-cpp"
