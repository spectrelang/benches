use std::collections::HashMap;
use std::time::Instant;

fn main() {
    const KEY_COUNT: u64 = 50_000;
    const OPERATIONS: u64 = 5_000_000;

    let mut map: HashMap<u64, u64> = HashMap::with_capacity(131072);

    let start = Instant::now();
    for i in 0..OPERATIONS {
        *map.entry(i % KEY_COUNT).or_insert(0) += 1;
    }
    let elapsed = start.elapsed().as_nanos();

    let mut checksum: u64 = 0;
    for i in 0..KEY_COUNT {
        checksum += *map.get(&i).unwrap_or(&0);
    }

    println!("Rust: {} ns", elapsed);
    println!("Checksum: {}", checksum);
}
