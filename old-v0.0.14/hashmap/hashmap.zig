const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const KEY_COUNT: u64 = 50_000;
    const OPERATIONS: u64 = 5_000_000;

    const allocator = std.heap.page_allocator;
    var map = std.AutoHashMap(u64, u64).init(allocator);
    defer map.deinit();
    try map.ensureTotalCapacity(131072);

    const start = std.Io.Clock.real.now(init.io).nanoseconds;
    for (0..OPERATIONS) |i| {
        const gop = try map.getOrPut(@as(u64, @intCast(i)) % KEY_COUNT);
        if (!gop.found_existing) gop.value_ptr.* = 0;
        gop.value_ptr.* += 1;
    }
    const elapsed = std.Io.Clock.real.now(init.io).nanoseconds - start;

    var checksum: u64 = 0;
    for (0..KEY_COUNT) |i| {
        checksum += map.get(@as(u64, @intCast(i))) orelse 0;
    }

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
