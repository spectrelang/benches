let ROUNDS = 6000000;
let STEP: u64 = 324743;

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + STEP) ^ (acc >> 7);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
