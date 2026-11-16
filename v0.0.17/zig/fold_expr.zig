const std = @import("std");

const A: i64 = 1234567;
const B: i64 = 7654321;
const ROUNDS: u64 = 6000000;

fn step(x: i64, y: i64) i64 {
    const a = x * 3 + y * 5;
    const b = @mod(a, 1000003);
    const c = @mod(b * b, 1000009);
    return c + @mod(a, 97);
}

const STEP: u64 = @intCast(step(A, B));

pub fn main() void {
    var acc: u64 = 0;
    var i: u64 = 0;
    while (i < ROUNDS) : (i += 1) {
        acc = (acc *% 1099511628211 +% STEP) ^ (acc >> 7);
    }
    std.debug.print("{d}\n", .{acc & 0x7fffffff});
}
