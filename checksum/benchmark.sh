#!/usr/bin/env bash
set -euo pipefail

# Zig: v0.17.0
# LDC2: v1.36.0
# Spectre: v0.0.12

spectre checksum.sx --release -o checksum-spectre --alt
zig build-exe checksum.zig -OReleaseFast -femit-bin=checksum-zig
ldc2 -O3 -release -boundscheck=off checksum.d -of=checksum-d

SPECTRE="./checksum-spectre"
ZIG="./checksum-zig"
D="./checksum-d"

for bin in "$SPECTRE" "$ZIG" "$D"; do
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
	"$SPECTRE" \
	"$ZIG" \
	"$D"
