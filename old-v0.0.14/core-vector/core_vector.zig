const std = @import("std");

const N: usize = 2048;
const ITERS: usize = 100_000;

pub fn main(init: std.process.Init) !void {
    const alloc = std.heap.page_allocator;
    const a = try alloc.alloc(u32, N);
    const b = try alloc.alloc(u32, N);
    const c = try alloc.alloc(u32, N);

    for (0..N) |i| {
        a[i] = @intCast(i % 97 + 1);
        b[i] = @intCast(i % 89 + 3);
        c[i] = @intCast(i % 83 + 5);
    }

    const start = std.Io.Clock.real.now(init.io).nanoseconds;

    for (0..ITERS) |_| {
        for (0..N) |i| {
            c[i] = c[i] +% a[i] *% b[i];
        }
    }

    const elapsed = std.Io.Clock.real.now(init.io).nanoseconds - start;

    var sum: u64 = 0;
    for (c) |v| {
        sum += v;
    }

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Zig: {d} ns/pass\n", .{@divTrunc(elapsed, ITERS)});
    std.debug.print("Checksum: {d}\n", .{sum});
}
