let A: i64 = 1234567;
let B: i64 = 7654321;
let ROUNDS = 6000000;

fn step(x: i64, y: i64) -> i64 {
    let a = x * 3 + y * 5;
    let b = a % 1000003;
    let c = (b * b) % 1000009;
    return c + a % 97;
}

fn main() {
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + step(A, B) as u64) ^ (acc >> 7);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
