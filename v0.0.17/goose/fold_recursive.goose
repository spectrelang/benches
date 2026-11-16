let ROUNDS = 4000000;
let FIB: u64 = 46368;

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + FIB) ^ (acc >> 7);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
