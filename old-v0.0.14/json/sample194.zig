const std = @import("std");

const iterations: usize = 1_000_000;

const input =
    \\{
    \\ "name":"Spectre",
    \\ "version":12,
    \\ "active":true,
    \\ "values":[1,2,3,4,5,6,7,8,9,10]
    \\}
;

pub fn main(init: std.process.Init) !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();
    const time = std.Io.Clock.real.now(init.io).nanoseconds;
    var checksum: i64 = 0;

    for (0..iterations) |_| {
        var doc = try std.json.parseFromSlice(
            std.json.Value,
            allocator,
            input,
            .{},
        );

        const root = doc.value;

        if (root == .object) {
            if (root.object.get("version")) |version| {
                if (version == .integer) {
                    checksum += version.integer;
                }
            }

            if (root.object.get("active")) |active| {
                if (active == .bool and active.bool) {
                    checksum += 1;
                }
            }
        }

        doc.deinit();
    }

    const time2 = std.Io.Clock.real.now(init.io).nanoseconds;
    const elapsed = time2 - time;

    std.debug.print("Zig: {d} ns\n", .{elapsed});
    std.debug.print("Zig: {d} ns/op\n", .{@divTrunc(elapsed, iterations)});
    std.debug.print("Checksum: {d}\n", .{checksum});
}
