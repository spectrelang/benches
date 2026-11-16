let SIZE = 4096;
let PASSES = 1024;
var table: u64[4096];

fn cell(i: u64) -> u64 {
    var x: u64 = i * 0x9e3779b97f4a7c15 + 1;
    var j = 0;
    while j < 128 {
        x ^= x >> 12;
        x ^= x << 25;
        x ^= x >> 27;
        x *= 2685821657736338717;
        j += 1;
    }
    return x;
}

fn fill_table() {
    var i = 0;
    while i < SIZE {
        table[i] = cell(i as u64);
        i += 1;
    }
}

fn main() {
    fill_table();
    var h: u64 = 14695981039346656037;
    var p = 0;
    while p < PASSES {
        var i = 0;
        while i < SIZE {
            h = (h ^ table[i]) * 1099511628211;
            i += 1;
        }
        p += 1;
    }
    print(h & 0x7fffffff);
}
