#!/usr/bin/env bash
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
out="$here/out"
results="$here/results"
mkdir -p "$out" "$results"

benches="fold_const fold_expr fold_loop fold_recursive table_hash"

for b in $benches; do
	echo "building $b"
	spectre "$here/spectre/$b.sx" -release -native -o "$out/${b}_spectre"
	cc -O3 -march=native "$here/c/$b.c" -o "$out/${b}_c"
	g++ -O3 -march=native -std=c++20 "$here/cpp/$b.cpp" -o "$out/${b}_cpp"
	zig build-exe -O ReleaseFast -mcpu=native "$here/zig/$b.zig" -femit-bin="$out/${b}_zig" >/dev/null
	goose build -O2 -o "$out/${b}_goose" "$here/goose/$b.goose" >/dev/null
	crystal build --release --mcpu native "$here/crystal/$b.cr" -o "$out/${b}_crystal"
done

for b in $benches; do
	echo "===== $b ====="
	hyperfine --warmup 3 --runs 10 --shell=none \
		--export-json "$results/$b.json" \
		--command-name spectre "$out/${b}_spectre" \
		--command-name c "$out/${b}_c" \
		--command-name cpp "$out/${b}_cpp" \
		--command-name zig "$out/${b}_zig" \
		--command-name goose "$out/${b}_goose" \
		--command-name crystal "$out/${b}_crystal"
done
