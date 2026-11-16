#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"
out="benches/out"
mkdir -p "$out"

spectre="$root/spectre-dev"
zig="/home/navid/Applications/Zig/zig-x86_64-linux-0.15.2/zig"
goose="/media/Overflow/Applications/Goose/goose"

for b in fold_const fold_expr fold_loop fold_recursive table_hash; do
    echo "building $b"
    "$spectre" "benches/spectre/$b.sx" -release -native -static-fuel:300000000 -o "$out/${b}_spectre"
    cc -O3 -march=native "benches/c/$b.c" -o "$out/${b}_c"
    g++ -O3 -march=native -std=c++20 "benches/cpp/$b.cpp" -o "$out/${b}_cpp"
    "$zig" build-exe -O ReleaseFast -mcpu=native "benches/zig/$b.zig" -femit-bin="$out/${b}_zig" >/dev/null
    "$goose" build -O2 -o "$out/${b}_goose" "benches/goose/$b.goose" >/dev/null
done

for b in fold_const fold_expr fold_loop fold_recursive table_hash; do
    echo "===== $b ====="
    hyperfine --warmup 3 --runs 10 --shell=none \
        --command-name spectre "$out/${b}_spectre" \
        --command-name c "$out/${b}_c" \
        --command-name cpp "$out/${b}_cpp" \
        --command-name zig "$out/${b}_zig" \
        --command-name goose "$out/${b}_goose"
done
