## Benchmarks

Output obtained via Hyperfine (`--warmup 3 --runs 15`).

### Ryzen 5 5600X (Linux x86_64)

CPU: Ryzen 5 5600X @ 4.7 GHz
RAM: 32 GB

Toolchains: Spectre 0.0.14 (4ce0322), Zig 0.17.0, LDC 1.36.0, Rust 1.93.1, Clang 18.1.3.

#### JSON

| Command               |     Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :-------------------- | ------------: | -------: | -------: | ----------: |
| `./benchmark-spectre` |  248.5 ± 10.6 |    237.4 |    270.9 |        1.00 |
| `./benchmark-zig`     | 1017.8 ± 19.7 |    994.2 |   1064.1 | 4.10 ± 0.19 |
| `./benchmark-d`       | 2362.5 ± 42.1 |   2331.3 |   2498.0 | 9.50 ± 0.44 |
| `./benchmark-rust`    |   469.7 ± 6.3 |    462.4 |    485.3 | 1.89 ± 0.08 |
| `./benchmark-cpp`     | 1645.8 ± 23.0 |   1620.9 |   1717.9 | 6.62 ± 0.30 |

#### JSON (large parse)

| Command                |    Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :--------------------- | -----------: | -------: | -------: | -----------: |
| `./json-parse-spectre` |   51.2 ± 0.9 |     49.0 |     52.3 |         1.00 |
| `./json-parse-zig`     |  786.8 ± 7.1 |    773.5 |    801.1 | 15.38 ± 0.32 |
| `./json-parse-d`       | 694.9 ± 22.4 |    682.3 |    770.7 | 13.58 ± 0.50 |
| `./json-parse-rust`    |  122.2 ± 4.8 |    115.4 |    127.5 |  2.39 ± 0.10 |
| `./json-parse-cpp`     |  526.2 ± 6.1 |    520.4 |    539.6 | 10.29 ± 0.22 |

#### JSON (large write)

| Command                |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------------- | ----------: | -------: | -------: | ----------: |
| `./json-write-spectre` |  70.8 ± 1.4 |     68.5 |     73.7 | 1.06 ± 0.03 |
| `./json-write-zig`     | 132.9 ± 6.4 |    125.4 |    146.2 | 1.99 ± 0.11 |
| `./json-write-d`       | 366.0 ± 4.3 |    358.3 |    374.6 | 5.47 ± 0.16 |
| `./json-write-rust`    |  66.9 ± 1.7 |     64.8 |     70.2 |        1.00 |
| `./json-write-cpp`     | 108.7 ± 4.6 |    102.7 |    118.1 | 1.62 ± 0.08 |

#### JSON (roundtrip)

| Command                    |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------------- | -----------: | -------: | -------: | ----------: |
| `./json-roundtrip-spectre` |  156.8 ± 3.3 |    153.7 |    167.6 |        1.00 |
| `./json-roundtrip-zig`     | 880.1 ± 15.5 |    862.1 |    919.1 | 5.61 ± 0.15 |
| `./json-roundtrip-d`       | 995.2 ± 22.1 |    963.7 |   1049.8 | 6.35 ± 0.19 |
| `./json-roundtrip-rust`    |  167.1 ± 5.2 |    162.2 |    173.8 | 1.07 ± 0.04 |
| `./json-roundtrip-cpp`     |  584.9 ± 5.2 |    579.4 |    593.8 | 3.73 ± 0.08 |

#### Checksum

| Command              |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------- | ---------: | -------: | -------: | ----------: |
| `./checksum-spectre` | 15.9 ± 0.4 |     15.6 |     16.8 |        1.00 |
| `./checksum-zig`     | 16.1 ± 0.3 |     15.9 |     16.8 | 1.02 ± 0.03 |
| `./checksum-d`       | 16.6 ± 0.3 |     16.4 |     17.4 | 1.05 ± 0.03 |
| `./checksum-rust`    | 15.9 ± 0.4 |     15.4 |     16.6 | 1.00 ± 0.03 |
| `./checksum-cpp`     | 16.4 ± 0.3 |     16.0 |     17.1 | 1.03 ± 0.03 |

#### Calls

| Command           |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :---------------- | ---------: | -------: | -------: | ----------: |
| `./calls-spectre` | 21.6 ± 0.2 |     21.3 |     22.1 |        1.00 |
| `./calls-zig`     | 30.8 ± 0.2 |     30.5 |     31.2 | 1.42 ± 0.02 |
| `./calls-d`       | 24.7 ± 0.2 |     24.4 |     25.2 | 1.14 ± 0.02 |
| `./calls-rust`    | 21.9 ± 0.2 |     21.6 |     22.5 | 1.01 ± 0.02 |
| `./calls-cpp`     | 23.9 ± 0.2 |     23.7 |     24.3 | 1.11 ± 0.01 |

#### Sort (5M u64 values)

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./sort-spectre` | 141.7 ± 1.7 |    139.7 |    146.0 | 1.54 ± 0.02 |
| `./sort-zig`     | 493.4 ± 3.0 |    484.4 |    497.2 | 5.36 ± 0.05 |
| `./sort-d`       | 343.5 ± 0.9 |    342.2 |    345.3 | 3.73 ± 0.03 |
| `./sort-rust`    |  92.1 ± 0.7 |     90.9 |     93.4 |        1.00 |
| `./sort-cpp`     | 283.9 ± 0.6 |    283.0 |    284.9 | 3.08 ± 0.02 |

#### Hashmap (i64 keys)

| Command             |  Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :------------------ | ---------: | -------: | -------: | -----------: |
| `./hashmap-spectre` | 16.8 ± 0.7 |     16.1 |     18.5 |  1.94 ± 0.09 |
| `./hashmap-zig`     | 30.1 ± 0.7 |     29.2 |     32.0 |  3.47 ± 0.12 |
| `./hashmap-d`       | 54.5 ± 0.4 |     53.8 |     55.3 |  6.27 ± 0.16 |
| `./hashmap-rust`    | 87.1 ± 0.4 |     86.5 |     87.9 | 10.03 ± 0.24 |
| `./hashmap-cpp`     |  8.7 ± 0.2 |      8.4 |      9.1 |         1.00 |

#### Core language (arithmetic, branches, recursion)

Spectre uses `--release --alt --native --unroll`; the other compilers use
their native optimization flags (`-O3 -march=native`, `-OReleaseFast
-mcpu=native`, `-C target-cpu=native`, and equivalent). The workload combines
a serial 64-bit hash chain, Collatz sequences, and recursive Fibonacci.

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./core-spectre` | 232.6 ± 0.7 |    231.9 |    234.3 | 1.01 ± 0.00 |
| `./core-zig`     | 231.7 ± 1.4 |    230.7 |    236.5 | 1.01 ± 0.01 |
| `./core-d`       | 230.3 ± 0.5 |    229.5 |    231.2 |        1.00 |
| `./core-rust`    | 230.8 ± 0.8 |    229.6 |    232.6 | 1.00 ± 0.00 |
| `./core-cpp`     | 230.4 ± 0.6 |    229.4 |    231.5 | 1.00 ± 0.00 |

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

