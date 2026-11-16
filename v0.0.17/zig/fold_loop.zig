const std = @import("std");

const N: u64 = 50000;
const ROUNDS: u64 = 400;

fn sumTo(n: u64) u64 {
    @setEvalBranchQuota(100000000);
    var s: u64 = 0;
    var i: u64 = 0;
    while (i < n) : (i += 1) s +%= (i * 7) % 13;
    return s;
}

const SUM = sumTo(N);

pub fn main() void {
    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < ROUNDS) : (i += 1) {
        acc = (acc +% SUM) ^ (acc >> 1);
    }
    std.debug.print("{d}\n", .{acc & 0x7fffffff});
}
