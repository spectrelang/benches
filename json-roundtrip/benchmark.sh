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

"$SPECTRE" roundtrip.sx --release -o json-roundtrip-spectre --alt
zig build-exe roundtrip.zig -OReleaseFast -femit-bin=json-roundtrip-zig
ldc2 -O3 -release -boundscheck=off roundtrip.d -of=json-roundtrip-d
cargo build --release
clang++ -O3 -std=c++17 $CXX_INCLUDE roundtrip.cpp -o json-roundtrip-cpp

cp target/release/benchmark-rust json-roundtrip-rust

for bin in json-roundtrip-spectre json-roundtrip-zig json-roundtrip-d json-roundtrip-rust json-roundtrip-cpp; do
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
	"./json-roundtrip-spectre" \
	"./json-roundtrip-zig" \
	"./json-roundtrip-d" \
	"./json-roundtrip-rust" \
	"./json-roundtrip-cpp"
