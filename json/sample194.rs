use serde_json::Value;
use std::time::Instant;

const ITERATIONS: usize = 1_000_000;

const INPUT: &str = r#"{
 "name":"Spectre",
 "version":12,
 "active":true,
 "values":[1,2,3,4,5,6,7,8,9,10]
}"#;

fn main() {
    let mut checksum: i64 = 0;

    let start = Instant::now();
    for _ in 0..ITERATIONS {
        let root: Value = serde_json::from_str(INPUT).unwrap();

        if let Value::Object(obj) = &root {
            if let Some(version) = obj.get("version") {
                if let Some(v) = version.as_i64() {
                    checksum += v;
                }
            }
            if let Some(active) = obj.get("active") {
                if active.as_bool() == Some(true) {
                    checksum += 1;
                }
            }
        }
    }
    let elapsed = start.elapsed().as_nanos();

    println!("Rust: {} ns", elapsed);
    println!("Rust: {} ns/op", elapsed / ITERATIONS as u128);
    println!("Checksum: {}", checksum);
}
