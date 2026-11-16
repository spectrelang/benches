use std::time::Instant;

const ITERATIONS: usize = 10_000_000;
const ARRAY_SIZE: usize = 1024;

fn main() {
    let mut data = [0i32; ARRAY_SIZE];
    for i in 0..ARRAY_SIZE {
        data[i] = ((i * 17 + 13) % 997) as i32;
    }

    let mut checksum: i64 = 0;

    let start = Instant::now();
    for i in 0..ITERATIONS {
        let idx = (i * 31) % ARRAY_SIZE;
        let x = data[idx];

        if (x & 1) == 0 {
            checksum += x as i64 * 3 + (i % 97) as i64;
        } else {
            checksum -= x as i64 * 2 - (i % 53) as i64;
        }

        checksum ^= (checksum << 7) | (checksum >> 3);
    }
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!("Rust: {} ns/op", elapsed / ITERATIONS as u128);
    println!("Checksum: {}", checksum);
}
