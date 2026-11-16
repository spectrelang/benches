const std = @import("std");

const ROUNDS: u64 = 4000000;

fn fib(n: u64) u64 {
    @setEvalBranchQuota(100000000);
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

const FIB = fib(24);

pub fn main() void {
    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < ROUNDS) : (i += 1) {
        acc = (acc *% 1099511628211 +% FIB) ^ (acc >> 7);
    }
    std.debug.print("{d}\n", .{acc & 0x7fffffff});
}
