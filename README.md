## Benchmarks

Output obtained via Hyperfine (`--warmup 3 --runs 15`).

### Ryzen 5 5600X (Linux x86_64)

CPU: Ryzen 5 5600X @ 4.7 GHz
RAM: 32 GB

Toolchains: Spectre 0.0.14 (b7faded), Zig 0.17.0, LDC 1.36.0, Rust 1.93.1, Clang 18.1.3.

#### JSON

| Command               |     Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :-------------------- | ------------: | -------: | -------: | -----------: |
| `./benchmark-spectre` |   172.0 ± 1.7 |    170.5 |    175.6 |         1.00 |
| `./benchmark-zig`     | 1029.6 ± 16.8 |   1014.3 |   1073.4 |  5.99 ± 0.11 |
| `./benchmark-d`       | 2422.7 ± 45.8 |   2376.4 |   2512.0 | 14.08 ± 0.30 |
| `./benchmark-rust`    |   470.2 ± 7.3 |    461.9 |    482.5 |  2.73 ± 0.05 |
| `./benchmark-cpp`     | 1648.7 ± 12.1 |   1625.4 |   1667.0 |  9.58 ± 0.12 |

#### JSON (large parse)

| Command                |    Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :--------------------- | -----------: | -------: | -------: | -----------: |
| `./json-parse-spectre` |   51.1 ± 0.9 |     49.8 |     52.7 |         1.00 |
| `./json-parse-zig`     | 787.5 ± 10.6 |    775.2 |    810.3 | 15.40 ± 0.35 |
| `./json-parse-d`       |  688.6 ± 5.7 |    680.2 |    702.3 | 13.47 ± 0.27 |
| `./json-parse-rust`    |  120.9 ± 4.2 |    117.4 |    127.7 |  2.37 ± 0.09 |
| `./json-parse-cpp`     | 545.0 ± 75.2 |    519.3 |    815.4 | 10.66 ± 1.48 |

#### JSON (large write)

| Command                |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------------- | ----------: | -------: | -------: | ----------: |
| `./json-write-spectre` |  71.5 ± 3.0 |     68.5 |     78.4 | 1.10 ± 0.05 |
| `./json-write-zig`     | 133.9 ± 4.3 |    126.9 |    139.9 | 2.06 ± 0.08 |
| `./json-write-d`       | 365.7 ± 5.7 |    358.1 |    378.4 | 5.61 ± 0.13 |
| `./json-write-rust`    |  65.1 ± 1.2 |     63.9 |     67.9 |        1.00 |
| `./json-write-cpp`     | 105.8 ± 3.2 |    101.8 |    112.4 | 1.62 ± 0.06 |

#### JSON (roundtrip)

| Command                    |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------------- | -----------: | -------: | -------: | ----------: |
| `./json-roundtrip-spectre` |  156.8 ± 1.5 |    155.0 |    159.8 |        1.00 |
| `./json-roundtrip-zig`     | 881.6 ± 12.1 |    864.2 |    914.2 | 5.62 ± 0.09 |
| `./json-roundtrip-d`       | 981.3 ± 11.4 |    971.5 |   1013.9 | 6.26 ± 0.09 |
| `./json-roundtrip-rust`    |  168.9 ± 5.3 |    162.6 |    174.5 | 1.08 ± 0.04 |
| `./json-roundtrip-cpp`     |  587.3 ± 3.8 |    582.5 |    593.3 | 3.75 ± 0.04 |

#### Checksum

| Command              |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------- | ---------: | -------: | -------: | ----------: |
| `./checksum-spectre` | 15.9 ± 0.4 |     15.5 |     17.1 | 1.00 ± 0.04 |
| `./checksum-zig`     | 16.1 ± 0.3 |     15.6 |     16.7 | 1.01 ± 0.03 |
| `./checksum-d`       | 16.9 ± 0.2 |     16.5 |     17.3 | 1.06 ± 0.03 |
| `./checksum-rust`    | 15.9 ± 0.4 |     15.4 |     16.6 |        1.00 |
| `./checksum-cpp`     | 16.5 ± 0.3 |     16.0 |     17.1 | 1.04 ± 0.03 |

#### Calls

| Command           |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :---------------- | ---------: | -------: | -------: | ----------: |
| `./calls-spectre` | 21.8 ± 0.3 |     21.4 |     22.3 |        1.00 |
| `./calls-zig`     | 31.0 ± 0.2 |     30.6 |     31.4 | 1.42 ± 0.02 |
| `./calls-d`       | 24.9 ± 0.4 |     24.5 |     25.6 | 1.14 ± 0.02 |
| `./calls-rust`    | 22.1 ± 0.2 |     21.8 |     22.5 | 1.02 ± 0.02 |
| `./calls-cpp`     | 24.2 ± 0.4 |     23.6 |     24.9 | 1.11 ± 0.02 |

#### Sort (5M u64 values)

| Command          |    Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | -----------: | -------: | -------: | ----------: |
| `./sort-spectre` |  144.4 ± 1.7 |    142.2 |    147.8 | 1.51 ± 0.03 |
| `./sort-zig`     | 509.7 ± 10.6 |    495.4 |    526.6 | 5.33 ± 0.13 |
| `./sort-d`       |  347.9 ± 6.6 |    343.4 |    370.6 | 3.64 ± 0.09 |
| `./sort-rust`    |   95.6 ± 1.3 |     92.6 |     97.8 |        1.00 |
| `./sort-cpp`     |  285.1 ± 1.1 |    283.5 |    287.1 | 2.98 ± 0.04 |

#### Hashmap (i64 keys)

| Command             |  Mean [ms] | Min [ms] | Max [ms] |     Relative |
| :------------------ | ---------: | -------: | -------: | -----------: |
| `./hashmap-spectre` | 17.7 ± 0.8 |     16.8 |     19.7 |  2.01 ± 0.11 |
| `./hashmap-zig`     | 30.6 ± 0.7 |     29.7 |     32.0 |  3.47 ± 0.14 |
| `./hashmap-d`       | 55.6 ± 1.2 |     54.1 |     58.7 |  6.31 ± 0.24 |
| `./hashmap-rust`    | 88.3 ± 1.6 |     85.8 |     92.2 | 10.03 ± 0.37 |
| `./hashmap-cpp`     |  8.8 ± 0.3 |      8.3 |      9.3 |         1.00 |

#### Core language (arithmetic, branches, recursion)

Spectre uses `-release -alt -native -unroll`; the other compilers use
their native optimization flags (`-O3 -march=native`, `-OReleaseFast
-mcpu=native`, `-C target-cpu=native`, and equivalent). The workload combines
a serial 64-bit hash chain, Collatz sequences, and recursive Fibonacci.

| Command          |   Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :--------------- | ----------: | -------: | -------: | ----------: |
| `./core-spectre` | 232.8 ± 1.7 |    231.4 |    236.2 | 1.01 ± 0.01 |
| `./core-zig`     | 231.6 ± 0.8 |    230.6 |    233.4 | 1.01 ± 0.00 |
| `./core-d`       | 230.8 ± 1.1 |    229.4 |    233.7 | 1.00 ± 0.01 |
| `./core-rust`    | 230.4 ± 0.7 |    229.7 |    232.5 |        1.00 |
| `./core-cpp`     | 231.0 ± 1.3 |    229.6 |    234.5 | 1.00 ± 0.01 |

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
