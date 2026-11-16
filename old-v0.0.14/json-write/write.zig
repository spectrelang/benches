const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const N: usize = 300_000;
    const ITERATIONS: usize = 20;

    const allocator = std.heap.page_allocator;
    var input: std.ArrayList(u8) = .empty;
    defer input.deinit(allocator);
    try input.append(allocator, '[');
    for (0..N) |i| {
        if (i > 0) try input.append(allocator, ',');
        try input.print(allocator, "{d}", .{i});
    }
    try input.append(allocator, ']');

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const parsed = try std.json.parseFromSlice(
        std.json.Value,
        arena.allocator(),
        input.items,
        .{},
    );

    const start = std.Io.Clock.real.now(init.io).nanoseconds;
    var checksum: i64 = 0;
    for (0..ITERATIONS) |_| {
        const out = try std.json.Stringify.valueAlloc(allocator, parsed.value, .{});
        defer allocator.free(out);
        checksum += @intCast(out.len);
    }
    const elapsed = std.Io.Clock.real.now(init.io).nanoseconds - start;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
