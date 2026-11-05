use serde_json::Value;
use std::time::Instant;

fn main() {
    const N: usize = 300_000;
    const ITERATIONS: usize = 20;

    let mut input = String::with_capacity(N * 8);
    input.push('[');
    for i in 0..N {
        if i > 0 {
            input.push(',');
        }
        input.push_str(&i.to_string());
    }
    input.push(']');

    let value: Value = serde_json::from_str(&input).unwrap();

    let start = Instant::now();
    let mut checksum: i64 = 0;
    for _ in 0..ITERATIONS {
        let out = serde_json::to_string(&value).unwrap();
        checksum += out.len() as i64;
    }
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!("Checksum: {}", checksum);
}
