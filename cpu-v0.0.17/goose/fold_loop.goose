let N = 50000;
let ROUNDS = 400;

fn sum_to(n: i64) -> i64 {
    var sum: i64 = 0;
    var i = 0;
    while i < n {
        sum += (i * 7) % 13;
        i += 1;
    }
    return sum;
}

fn main() {
    var acc: u64 = 0;
    var r = 0;
    while r < ROUNDS {
        acc = (acc + sum_to(N) as u64) ^ (acc >> 1);
        r += 1;
    }
    print(acc & 0x7fffffff);
}
