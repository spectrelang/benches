const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const N: usize = 5_000_000;
    const allocator = std.heap.page_allocator;
    const xs = try allocator.alloc(u64, N);
    defer allocator.free(xs);

    var seed: u64 = 123456789;
    for (0..N) |i| {
        seed = seed *% 6364136223846793005 +% 1442695040888963407;
        xs[i] = seed & 0xffffffff;
    }

    const start = std.Io.Clock.real.now(init.io).nanoseconds;
    std.mem.sort(u64, xs, {}, std.sort.asc(u64));
    var checksum: u64 = 0;
    for (xs) |v| checksum ^= v;
    const elapsed = std.Io.Clock.real.now(init.io).nanoseconds - start;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
