#!/usr/bin/env bash
set -euo pipefail

# Zig: v0.17.0
# LDC2: v1.36.0
# Spectre: v0.0.12

spectre sample194.sx --release -o benchmark-spectre
zig build-exe sample194.zig -OReleaseFast -femit-bin=benchmark-zig
ldc2 -O3 -release -boundscheck=off sample194.d -of=benchmark-d

SPECTRE="./benchmark-spectre"
ZIG="./benchmark-zig"
D="./benchmark-d"

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
