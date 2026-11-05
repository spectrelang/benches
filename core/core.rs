use std::time::Instant;

const MIX_ITERATIONS: u64 = 40_000_000;
const COLLATZ_LIMIT: u64 = 1_000_000;
const FIB_N: u64 = 35;

#[inline]
fn mix(x: u64) -> u64 {
    let mut y = x;
    y = (y ^ (y >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
    y = (y ^ (y >> 27)).wrapping_mul(0x94d049bb133111eb);
    y ^ (y >> 31)
}

fn collatz(mut n: u64) -> u64 {
    let mut steps = 0;
    while n != 1 {
        if n & 1 == 0 {
            n >>= 1;
        } else {
            n = n.wrapping_mul(3).wrapping_add(1);
        }
        steps += 1;
    }
    steps
}

#[inline(never)]
fn fib(n: u64) -> u64 {
    if n < 2 {
        return n;
    }
    fib(n - 1) + fib(n - 2)
}

fn main() {
    let start = Instant::now();
    let mut checksum: u64 = 0x123456789abcdef;

    for i in 0..MIX_ITERATIONS {
        checksum = mix(checksum.wrapping_add(i));
    }

    for n in 1..COLLATZ_LIMIT {
        checksum = checksum.wrapping_add(collatz(n));
    }

    checksum = checksum.wrapping_add(fib(FIB_N));
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!(
        "Rust: {} ns/op",
        elapsed / (MIX_ITERATIONS + COLLATZ_LIMIT) as u128
    );
    println!("Checksum: {}", checksum);
}
