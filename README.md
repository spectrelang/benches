## Benchmarks

Output obtained via Hyperfine (`--warmup 3 --runs 15`). Run `./run-benchmarks.sh`
to execute every workload and refresh this file (`--no-run` rebuilds the tables
from the existing result files).

### Ryzen 5 5600X (Linux x86_64)

CPU: Ryzen 5 5600X @ 4.7 GHz
RAM: 32 GB

Toolchains: Spectre 0.0.14 (ff4c93b), Zig 0.17.0, LDC 1.36.0, Rust 1.93.1, Clang 18.1.3.

#### JSON

| Command               |     Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :-------------------- | ------------: | -------: | -------: | -----------: |
| `./benchmark-spectre` |   173.3 ± 1.2 |    171.9 |    175.5 |         1.00 |
| `./benchmark-zig`     | 1055.1 ± 14.1 |   1033.1 |   1081.0 |  6.09 ± 0.09 |
| `./benchmark-d`       | 2363.2 ± 20.9 |   2335.4 |   2402.2 | 13.64 ± 0.15 |
| `./benchmark-rust`    |  476.1 ± 16.1 |    464.9 |    531.0 |  2.75 ± 0.09 |
| `./benchmark-cpp`     | 1648.2 ± 18.9 |   1626.4 |   1689.3 |  9.51 ± 0.13 |

#### JSON (large parse)

| Command                |    Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :--------------------- | -----------: | -------: | -------: | -----------: |
| `./json-parse-spectre` |   51.0 ± 1.0 |     49.5 |     52.7 |         1.00 |
| `./json-parse-zig`     |  780.0 ± 6.7 |    773.6 |    800.0 | 15.31 ± 0.33 |
| `./json-parse-d`       | 700.6 ± 43.4 |    679.5 |    853.9 | 13.75 ± 0.89 |
| `./json-parse-rust`    |  122.3 ± 4.5 |    116.2 |    127.7 |  2.40 ± 0.10 |
| `./json-parse-cpp`     |  526.6 ± 9.9 |    518.1 |    548.8 | 10.33 ± 0.28 |

#### JSON (large write)

| Command                |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------------- | -----------: | -------: | -------: | ----------: |
| `./json-write-spectre` |   70.0 ± 1.0 |     69.2 |     72.5 | 1.07 ± 0.02 |
| `./json-write-zig`     | 136.4 ± 11.2 |    127.5 |    173.3 | 2.08 ± 0.17 |
| `./json-write-d`       |  361.9 ± 4.6 |    354.9 |    370.9 | 5.51 ± 0.12 |
| `./json-write-rust`    |   65.7 ± 1.1 |     64.0 |     67.9 |        1.00 |
| `./json-write-cpp`     |  106.2 ± 2.9 |    102.5 |    111.7 | 1.62 ± 0.05 |

#### JSON (roundtrip)

| Command                    |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------------- | -----------: | -------: | -------: | ----------: |
| `./json-roundtrip-spectre` |  156.4 ± 2.0 |    154.4 |    160.7 |        1.00 |
| `./json-roundtrip-zig`     | 879.5 ± 11.1 |    865.1 |    902.7 | 5.62 ± 0.10 |
| `./json-roundtrip-d`       | 986.7 ± 13.4 |    974.1 |   1016.9 | 6.31 ± 0.12 |
| `./json-roundtrip-rust`    |  170.1 ± 6.5 |    162.7 |    180.5 | 1.09 ± 0.04 |
| `./json-roundtrip-cpp`     |  589.1 ± 4.9 |    582.7 |    601.9 | 3.77 ± 0.06 |

#### Checksum

| Command              |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------- | ---------: | -------: | -------: | ----------: |
| `./checksum-spectre` | 16.0 ± 0.3 |     15.7 |     16.8 |        1.00 |
| `./checksum-zig`     | 16.1 ± 0.3 |     15.8 |     17.1 | 1.00 ± 0.03 |
| `./checksum-d`       | 16.8 ± 0.4 |     16.5 |     17.6 | 1.05 ± 0.03 |
| `./checksum-rust`    | 16.3 ± 1.3 |     15.5 |     20.8 | 1.01 ± 0.08 |
| `./checksum-cpp`     | 16.6 ± 0.4 |     16.2 |     17.6 | 1.03 ± 0.03 |

#### Calls

| Command           |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :---------------- | ---------: | -------: | -------: | ----------: |
| `./calls-spectre` | 21.9 ± 0.3 |     21.5 |     22.4 | 1.00 ± 0.02 |
| `./calls-zig`     | 30.9 ± 0.2 |     30.5 |     31.3 | 1.41 ± 0.02 |
| `./calls-d`       | 25.0 ± 0.3 |     24.6 |     25.6 | 1.14 ± 0.02 |
| `./calls-rust`    | 21.9 ± 0.2 |     21.5 |     22.3 |        1.00 |
| `./calls-cpp`     | 24.0 ± 0.3 |     23.5 |     24.6 | 1.10 ± 0.02 |

#### Sort (5M u64 values)

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./sort-spectre` | 143.1 ± 1.2 |    141.6 |    145.1 | 1.52 ± 0.02 |
| `./sort-zig`     | 495.7 ± 2.0 |    493.3 |    501.0 | 5.28 ± 0.07 |
| `./sort-d`       | 345.5 ± 2.0 |    342.5 |    350.5 | 3.68 ± 0.05 |
| `./sort-rust`    |  93.9 ± 1.1 |     91.4 |     95.8 |        1.00 |
| `./sort-cpp`     | 284.7 ± 1.2 |    282.5 |    286.4 | 3.03 ± 0.04 |

#### Hashmap (i64 keys)

| Command             |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------ | ---------: | -------: | -------: | ----------: |
| `./hashmap-spectre` | 17.7 ± 1.0 |     16.6 |     20.5 | 2.01 ± 0.14 |
| `./hashmap-zig`     | 30.6 ± 0.9 |     29.1 |     32.2 | 3.48 ± 0.18 |
| `./hashmap-d`       | 54.4 ± 1.0 |     53.1 |     56.7 | 6.19 ± 0.29 |
| `./hashmap-rust`    | 87.6 ± 1.2 |     86.0 |     90.1 | 9.95 ± 0.45 |
| `./hashmap-cpp`     |  8.8 ± 0.4 |      8.3 |      9.7 |        1.00 |

#### Core language (arithmetic, branches, recursion)

Spectre uses `-release -alt -native -unroll`; the other compilers use
their native optimization flags (`-O3 -march=native`, `-OReleaseFast
-mcpu=native`, `-C target-cpu=native`, and equivalent). The workload combines
a serial 64-bit hash chain, Collatz sequences, and recursive Fibonacci.

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./core-spectre` | 232.2 ± 0.7 |    231.6 |    234.2 | 1.01 ± 0.00 |
| `./core-zig`     | 231.9 ± 1.0 |    230.6 |    234.3 | 1.01 ± 0.01 |
| `./core-d`       | 230.9 ± 1.0 |    230.0 |    233.4 | 1.00 ± 0.01 |
| `./core-rust`    | 230.2 ± 0.7 |    229.4 |    232.0 |        1.00 |
| `./core-cpp`     | 230.7 ± 0.9 |    229.5 |    233.0 | 1.00 ± 0.00 |

#### Core language

Spectre uses `-release -alt -native -unroll -dynamic`; the other compilers use
their native optimization flags. The workload performs repeated 32-bit
multiply-add over three 2,048-element arrays held in L1 cache. The Spectre
version uses 32-byte-aligned buffers so the `-alt` autovectorizer can emit
8-lane AVX2 loop bodies. All implementations use the same algorithm and
produce the same checksum.

| Command                 |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :---------------------- | ---------: | -------: | -------: | ----------: |
| `./core-vector-spectre` | 10.1 ± 0.7 |      9.4 |     11.3 |        1.00 |
| `./core-vector-zig`     | 54.6 ± 0.8 |     53.7 |     55.8 | 5.39 ± 0.37 |
| `./core-vector-d`       | 17.4 ± 0.3 |     17.0 |     18.1 | 1.72 ± 0.12 |
| `./core-vector-rust`    | 12.6 ± 0.3 |     12.1 |     13.0 | 1.24 ± 0.09 |
| `./core-vector-cpp`     | 14.5 ± 0.4 |     14.0 |     15.3 | 1.43 ± 0.10 |

### Apple M2 (macOS arm64)

CPU: Apple M2
RAM: 16 GB

Toolchains: Zig 0.17.0, LDC 1.41.0, Rust 1.94.0, Apple clang 16.

#### JSON

| Command               |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :-------------------- | -----------: | -------: | -------: | ----------: |
| `./benchmark-spectre` |  303.3 ± 6.7 |    294.4 |    318.4 |        1.00 |
| `./benchmark-zig`     |  712.1 ± 2.5 |    709.3 |    716.9 | 2.35 ± 0.05 |
| `./benchmark-d`       | 1710.4 ± 4.5 |   1700.4 |   1716.0 | 5.64 ± 0.13 |
| `./benchmark-rust`    |  472.5 ± 2.5 |    469.1 |    478.9 | 1.56 ± 0.04 |
| `./benchmark-cpp`     | 1341.5 ± 6.2 |   1333.4 |   1355.3 | 4.42 ± 0.10 |

#### JSON (large parse)

| Command                |   Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :--------------------- | ----------: | -------: | -------: | -----------: |
| `./json-parse-spectre` |  50.8 ± 0.4 |     49.8 |     51.5 |         1.00 |
| `./json-parse-zig`     | 316.8 ± 1.9 |    312.8 |    319.9 |  6.23 ± 0.06 |
| `./json-parse-d`       | 575.2 ± 1.1 |    573.5 |    577.8 | 11.32 ± 0.10 |
| `./json-parse-rust`    |  88.4 ± 0.4 |     87.2 |     88.9 |  1.74 ± 0.02 |
| `./json-parse-cpp`     | 327.3 ± 1.3 |    324.4 |    329.1 |  6.44 ± 0.06 |

#### JSON (large write)

| Command                |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------------- | ----------: | -------: | -------: | ----------: |
| `./json-write-spectre` |  44.6 ± 0.6 |     43.8 |     45.6 |        1.00 |
| `./json-write-zig`     |  97.2 ± 0.7 |     96.1 |     98.7 | 2.18 ± 0.03 |
| `./json-write-d`       | 283.9 ± 3.5 |    279.2 |    292.6 | 6.36 ± 0.11 |
| `./json-write-rust`    |  64.4 ± 0.5 |     63.4 |     65.1 | 1.44 ± 0.02 |
| `./json-write-cpp`     |  97.8 ± 0.4 |     96.8 |     98.5 | 2.19 ± 0.03 |

#### JSON (roundtrip)

| Command                    |   Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :------------------------- | ----------: | -------: | -------: | -----------: |
| `./json-roundtrip-spectre` |  71.7 ± 0.4 |     70.7 |     72.2 |         1.00 |
| `./json-roundtrip-zig`     | 394.0 ± 2.8 |    389.5 |    398.6 |  5.50 ± 0.05 |
| `./json-roundtrip-d`       | 844.1 ± 3.4 |    838.7 |    849.6 | 11.78 ± 0.08 |
| `./json-roundtrip-rust`    | 141.7 ± 3.7 |    139.5 |    154.6 |  1.98 ± 0.05 |
| `./json-roundtrip-cpp`     | 404.7 ± 5.0 |    399.2 |    414.6 |  5.65 ± 0.08 |

#### Checksum

| Command              |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------- | ---------: | -------: | -------: | ----------: |
| `./checksum-spectre` | 31.5 ± 8.1 |     28.3 |     60.7 | 1.59 ± 0.41 |
| `./checksum-zig`     | 29.7 ± 0.6 |     28.7 |     30.3 | 1.50 ± 0.05 |
| `./checksum-d`       | 29.6 ± 0.5 |     28.7 |     30.3 | 1.50 ± 0.05 |
| `./checksum-rust`    | 19.8 ± 0.5 |     19.2 |     20.6 |        1.00 |
| `./checksum-cpp`     | 28.9 ± 0.6 |     28.0 |     29.8 | 1.46 ± 0.05 |

#### Calls

| Command           |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :---------------- | ---------: | -------: | -------: | ----------: |
| `./calls-spectre` | 17.0 ± 0.7 |     16.0 |     18.2 | 1.26 ± 0.07 |
| `./calls-zig`     | 13.5 ± 0.5 |     12.7 |     14.3 |        1.00 |
| `./calls-d`       | 23.6 ± 0.6 |     22.6 |     24.4 | 1.75 ± 0.08 |
| `./calls-rust`    | 16.3 ± 0.7 |     15.1 |     17.2 | 1.21 ± 0.07 |
| `./calls-cpp`     | 17.2 ± 0.9 |     16.1 |     19.4 | 1.28 ± 0.09 |

#### Sort (5M u64 values)

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./sort-spectre` |  53.1 ± 0.7 |     51.6 |     54.5 |        1.00 |
| `./sort-zig`     | 462.7 ± 2.2 |    459.2 |    467.0 | 8.71 ± 0.13 |
| `./sort-d`       | 359.7 ± 1.5 |    357.7 |    363.9 | 6.77 ± 0.10 |
| `./sort-rust`    |  76.1 ± 0.5 |     75.2 |     77.3 | 1.43 ± 0.02 |
| `./sort-cpp`     | 119.1 ± 0.5 |    118.0 |    119.9 | 2.24 ± 0.03 |

#### Hashmap (i64 keys)

| Command             |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------ | ---------: | -------: | -------: | ----------: |
| `./hashmap-spectre` |  8.7 ± 0.5 |      8.2 |      9.9 |        1.00 |
| `./hashmap-zig`     | 22.0 ± 0.5 |     21.0 |     22.7 | 2.51 ± 0.17 |
| `./hashmap-d`       | 48.5 ± 0.8 |     47.1 |     50.3 | 5.55 ± 0.35 |
| `./hashmap-rust`    | 44.8 ± 0.6 |     43.4 |     45.8 | 5.13 ± 0.32 |
| `./hashmap-cpp`     | 15.6 ± 0.6 |     14.9 |     16.4 | 1.78 ± 0.13 |
