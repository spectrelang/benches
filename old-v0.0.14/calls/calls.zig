const std = @import("std");

const iterations: usize = 10_000_000;

fn mix(a: i64, b: i64, c: i64) i64 {
    return (a * 31 + b * 17 - c * 13) ^ ((a + b) << 3);
}

pub fn main(init: std.process.Init) !void {
    var checksum: i64 = 0;

    const start = std.Io.Clock.real.now(init.io).nanoseconds;

    for (0..iterations) |i| {
        const a: i64 = @intCast(i % 997);
        const b: i64 = @intCast(i % 313);
        const c: i64 = @intCast(i % 127);

        checksum += mix(a, b, c);
    }

    const end = std.Io.Clock.real.now(init.io).nanoseconds;
    const elapsed = end - start;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Zig: {d} ns/op\n", .{@divTrunc(elapsed, iterations)});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
