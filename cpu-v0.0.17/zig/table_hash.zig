const std = @import("std");

const SIZE: u64 = 4096;
const PASSES: u64 = 1024;

var table: [SIZE]u64 = undefined;

fn cell(i: u64) u64 {
    var x: u64 = i *% 0x9e3779b97f4a7c15 +% 1;
    var j: u64 = 0;
    while (j < 128) : (j += 1) {
        x ^= x >> 12;
        x ^= x << 25;
        x ^= x >> 27;
        x *%= 2685821657736338717;
    }
    return x;
}

fn fillTable() void {
    var i: u64 = 0;
    while (i < SIZE) : (i += 1) table[i] = cell(i);
}

pub fn main() void {
    fillTable();
    var h: u64 = 14695981039346656037;
    var p: u64 = 0;
    while (p < PASSES) : (p += 1) {
        var i: u64 = 0;
        while (i < SIZE) : (i += 1) {
            h = (h ^ table[i]) *% 1099511628211;
        }
    }
    std.debug.print("{d}\n", .{h & 0x7fffffff});
}
