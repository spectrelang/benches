let ROUNDS = 400;
let SUM: u64 = 299995;

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc + SUM) ^ (acc >> 1);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
