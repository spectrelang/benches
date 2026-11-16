use std::time::Instant;

fn main() {
    const N: usize = 5_000_000;
    let mut xs: Vec<u64> = Vec::with_capacity(N);
    let mut seed: u64 = 123456789;
    for _ in 0..N {
        seed = seed
            .wrapping_mul(6364136223846793005)
            .wrapping_add(1442695040888963407);
        xs.push(seed & 0xffffffff);
    }

    let start = Instant::now();
    xs.sort_unstable();
    let mut checksum: u64 = 0;
    for &v in &xs {
        checksum ^= v;
    }
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!("Checksum: {}", checksum);
}
