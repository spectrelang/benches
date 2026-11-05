use std::time::Instant;

const N: usize = 2048;
const ITERS: usize = 100_000;

fn main() {
    let mut a = vec![0u32; N];
    let mut b = vec![0u32; N];
    let mut c = vec![0u32; N];

    for i in 0..N {
        a[i] = (i % 97 + 1) as u32;
        b[i] = (i % 89 + 3) as u32;
        c[i] = (i % 83 + 5) as u32;
    }

    let start = Instant::now();

    for _ in 0..ITERS {
        for i in 0..N {
            c[i] = c[i].wrapping_add(a[i].wrapping_mul(b[i]));
        }
    }

    let elapsed = start.elapsed().as_nanos();
    let sum: u64 = c.iter().map(|v| *v as u64).sum();

    println!("Rust: {} ns", elapsed);
    println!("Rust: {} ns/pass", elapsed / ITERS as u128);
    println!("Checksum: {}", sum);
}
