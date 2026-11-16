let ROUNDS = 4000000;
let MIX: u64 = 7065331290632341489;
let COLL: u64 = 77;

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + MIX) ^ COLL;
        i += 1;
    }
    print(acc & 0x7fffffff);
}
