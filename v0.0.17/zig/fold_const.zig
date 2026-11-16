const std = @import("std");

const SEED: u64 = 123456789;
const ROUNDS: u64 = 4000000;

fn mix(x0: u64) u64 {
    var x = x0;
    x ^= x >> 13;
    x *%= 1000003;
    x ^= x >> 7;
    x *%= 2654435761;
    return x;
}

fn collatz(n0: u64) u64 {
    @setEvalBranchQuota(100000000);
    var n = n0;
    var steps: u64 = 0;
    while (n != 1) : (steps += 1) {
        n = if (n % 2 == 0) n / 2 else 3 * n + 1;
    }
    return steps;
}

const MIX = mix(SEED);
const COLL = collatz(SEED % 1000 + 1);

pub fn main() void {
    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < ROUNDS) : (i += 1) {
        acc = (acc *% 1099511628211 +% MIX) ^ COLL;
    }
    std.debug.print("{d}\n", .{acc & 0x7fffffff});
}
