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

CXX_INCLUDE=""
for dir in ../vendor /opt/homebrew/include /usr/local/include /usr/include; do
	if [[ -f "$dir/nlohmann/json.hpp" ]]; then
		CXX_INCLUDE="-I$dir"
		break
	fi
done

"$SPECTRE" sample194.sx -release -alt -native -o benchmark-spectre
zig build-exe sample194.zig -OReleaseFast -femit-bin=benchmark-zig
ldc2 -O3 -release -boundscheck=off sample194.d -of=benchmark-d
cargo build --release
clang++ -O3 -std=c++17 $CXX_INCLUDE sample194.cpp -o benchmark-cpp

cp target/release/benchmark-rust benchmark-rust

for bin in benchmark-spectre benchmark-zig benchmark-d benchmark-rust benchmark-cpp; do
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
	"./benchmark-spectre" \
	"./benchmark-zig" \
	"./benchmark-d" \
	"./benchmark-rust" \
	"./benchmark-cpp"
