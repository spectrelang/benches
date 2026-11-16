const std = @import("std");

const MIX_ITERATIONS: u64 = 40_000_000;
const COLLATZ_LIMIT: u64 = 1_000_000;
const FIB_N: u64 = 35;

inline fn mix(x: u64) u64 {
    var y = x;
    y = (y ^ (y >> 30)) *% 0xbf58476d1ce4e5b9;
    y = (y ^ (y >> 27)) *% 0x94d049bb133111eb;
    return y ^ (y >> 31);
}

fn collatz(n0: u64) u64 {
    var n = n0;
    var steps: u64 = 0;
    while (n != 1) {
        if (n & 1 == 0) {
            n >>= 1;
        } else {
            n = n *% 3 +% 1;
        }
        steps += 1;
    }
    return steps;
}

noinline fn fib(n: u64) u64 {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

pub fn main(init: std.process.Init) !void {
    const start = std.Io.Clock.real.now(init.io).nanoseconds;
    var checksum: u64 = 0x123456789abcdef;

    for (0..MIX_ITERATIONS) |i| {
        checksum = mix(checksum +% @as(u64, @intCast(i)));
    }

    var n: u64 = 1;
    while (n < COLLATZ_LIMIT) : (n += 1) {
        checksum +%= collatz(n);
    }

    checksum +%= fib(FIB_N);
    const elapsed = std.Io.Clock.real.now(init.io).nanoseconds - start;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Zig: {d} ns/op\n", .{@divTrunc(elapsed, MIX_ITERATIONS + COLLATZ_LIMIT)});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
