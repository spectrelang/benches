let SEED: u64 = 123456789;
let ROUNDS = 4000000;

fn mix(x: u64) -> u64 {
    var v = x;
    v ^= v >> 13;
    v *= 1000003;
    v ^= v >> 7;
    v *= 2654435761;
    return v;
}

fn collatz(n: u64) -> u64 {
    var x = n;
    var steps: u64 = 0;
    while x != 1 {
        if x % 2 == 0 {
            x /= 2;
        } else {
            x = 3 * x + 1;
        }
        steps += 1;
    }
    return steps;
}

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + mix(SEED)) ^ collatz(SEED % 1000 + 1);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
