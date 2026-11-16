use std::time::Instant;

const ITERATIONS: usize = 10_000_000;

#[inline]
fn mix(a: i64, b: i64, c: i64) -> i64 {
    (a * 31 + b * 17 - c * 13) ^ ((a + b) << 3)
}

fn main() {
    let mut checksum: i64 = 0;

    let start = Instant::now();
    for i in 0..ITERATIONS {
        let a = (i % 997) as i64;
        let b = (i % 313) as i64;
        let c = (i % 127) as i64;
        checksum += mix(a, b, c);
    }
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!("Rust: {} ns/op", elapsed / ITERATIONS as u128);
    println!("Checksum: {}", checksum);
}
