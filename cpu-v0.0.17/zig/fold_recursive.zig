const std = @import("std");

const ROUNDS: u64 = 4000000;

fn fib(n: u64) u64 {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

pub fn main() void {
    const fibv = fib(24);
    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < ROUNDS) : (i += 1) {
        acc = (acc *% 1099511628211 +% fibv) ^ (acc >> 7);
    }
    std.debug.print("{d}\n", .{acc & 0x7fffffff});
}
