const std = @import("std");

const iterations: usize = 10_000_000;
const array_size: usize = 1024;

pub fn main(init: std.process.Init) !void {
    var data: [array_size]i32 = undefined;

    for (0..array_size) |i| {
        data[i] = @intCast((i * 17 + 13) % 997);
    }

    var checksum: i64 = 0;

    const start = std.Io.Clock.real.now(init.io).nanoseconds;

    for (0..iterations) |i| {
        const idx = (i * 31) % array_size;
        const x = data[idx];

        if ((x & 1) == 0) {
            checksum += @as(i64, x) * 3 + @as(i64, @intCast(i % 97));
        } else {
            checksum -= @as(i64, x) * 2 - @as(i64, @intCast(i % 53));
        }

        checksum ^= (checksum << 7) | (checksum >> 3);
    }

    const end = std.Io.Clock.real.now(init.io).nanoseconds;
    const elapsed = end - start;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Zig: {d} ns/op\n", .{@divTrunc(elapsed, iterations)});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
