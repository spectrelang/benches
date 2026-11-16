let ROUNDS = 4000000;

recursive fn fib(n: i64) -> i64 {
    if n < 2 {
        return n;
    }
    return fib(n - 1) + fib(n - 2);
}

fn main() {
    let fibv: u64 = fib(24) as u64;
    var acc: u64 = 0;
    var i = 0;
    while i < ROUNDS {
        acc = (acc * 1099511628211 + fibv) ^ (acc >> 7);
        i += 1;
    }
    print(acc & 0x7fffffff);
}
