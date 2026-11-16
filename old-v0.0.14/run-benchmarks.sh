#!/usr/bin/env bash
# Run every benchmark and refresh the matching README section.
#
# Usage: ./run-benchmarks.sh [--no-run]
#   --no-run            Rebuild README from existing benchmark-results.md files.
#   BENCH_SECTION=...   Target a different README section heading.
#   SPECTRE=...         Use a specific Spectre compiler binary.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

BENCHMARKS=(
	json
	json-parse
	json-write
	json-roundtrip
	checksum
	calls
	sort
	hashmap
	core
	core-vector
)

if [[ -n "${BENCH_SECTION:-}" ]]; then
	SECTION="$BENCH_SECTION"
elif [[ "$(uname -s)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
	SECTION="Apple M2 (macOS arm64)"
else
	SECTION="Ryzen 5 5600X (Linux x86_64)"
fi

if [[ "${1:-}" != "--no-run" ]]; then
	for benchmark in "${BENCHMARKS[@]}"; do
		echo "==> ${benchmark}"
		(cd "$benchmark" && ./benchmark.sh)
	done
fi

if [[ -z "${SPECTRE:-}" ]]; then
	if [[ -x "$ROOT/../spectre/spectre-dev" ]]; then
		SPECTRE="$ROOT/../spectre/spectre-dev"
	else
		SPECTRE="spectre"
	fi
fi

spectre_line="$("$SPECTRE" -version 2>/dev/null | head -n 1 || true)"
spectre_version="$(sed -nE 's/^Spectre v?([0-9]+\.[0-9]+\.[0-9]+).*/\1/p' <<<"$spectre_line")"
spectre_hash="$(sed -nE 's/.*\(([^)]+)\).*/\1/p' <<<"$spectre_line")"

if [[ -d "$ROOT/../spectre/.git" ]]; then
	if [[ -z "$spectre_hash" || "$spectre_hash" == *unknown* ]]; then
		spectre_hash="$(git -C "$ROOT/../spectre" rev-parse --short HEAD 2>/dev/null || true)"
	fi
	if [[ -n "$(git -C "$ROOT/../spectre" status --porcelain 2>/dev/null || true)" ]]; then
		if [[ -n "$spectre_hash" ]]; then
			spectre_hash="${spectre_hash} + local SIMD"
		else
			spectre_hash="local SIMD"
		fi
	fi
fi

zig_version="$(zig version 2>/dev/null || true)"
ldc_version="$(ldc2 --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 || true)"
rust_version="$(rustc --version 2>/dev/null | awk '{print $2}' || true)"
clang_version="$(clang++ --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 || true)"

TOOLCHAINS="Spectre ${spectre_version:-unknown}"
if [[ -n "$spectre_hash" ]]; then
	TOOLCHAINS+=" (${spectre_hash})"
fi
TOOLCHAINS+=", Zig ${zig_version:-unknown}, LDC ${ldc_version:-unknown}, Rust ${rust_version:-unknown}, Clang ${clang_version:-unknown}."

python3 "$ROOT/scripts/update-readme.py" \
	--section "$SECTION" \
	--toolchains "$TOOLCHAINS"
