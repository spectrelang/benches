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

CXX_INCLUDE=""
for dir in /opt/homebrew/include /usr/local/include /usr/include; do
	if [[ -f "$dir/nlohmann/json.hpp" ]]; then
		CXX_INCLUDE="-I$dir"
		break
	fi
done

"$SPECTRE" parse.sx --release -o json-parse-spectre --alt
zig build-exe parse.zig -OReleaseFast -femit-bin=json-parse-zig
ldc2 -O3 -release -boundscheck=off parse.d -of=json-parse-d
cargo build --release
clang++ -O3 -std=c++17 $CXX_INCLUDE parse.cpp -o json-parse-cpp

cp target/release/benchmark-rust json-parse-rust

for bin in json-parse-spectre json-parse-zig json-parse-d json-parse-rust json-parse-cpp; do
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
	"./json-parse-spectre" \
	"./json-parse-zig" \
	"./json-parse-d" \
	"./json-parse-rust" \
	"./json-parse-cpp"
