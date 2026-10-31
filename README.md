## Benchmarks

Output obtained via Hyperfine. All tests are run on:

CPU: Ryzen 5 5600X @ 4.7 GHz
RAM: 32 GB DDR5

### JSON

| Command               |     Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :-------------------- | ------------: | -------: | -------: | ----------: |
| `./benchmark-spectre` |   246.2 ± 3.9 |    238.4 |    251.7 |        1.00 |
| `./benchmark-zig`     | 1055.6 ± 17.0 |   1034.1 |   1089.4 | 4.29 ± 0.10 |
| `./benchmark-d`       | 2383.6 ± 24.7 |   2357.5 |   2460.6 | 9.68 ± 0.18 |

### Checksum

| Command              |  Mean [ms] | Min [ms] | Max [ms] |    Relative |
| :------------------- | ---------: | -------: | -------: | ----------: |
| `./checksum-spectre` | 16.2 ± 0.7 |     15.7 |     18.4 |        1.00 |
| `./checksum-zig`     | 16.3 ± 0.4 |     15.8 |     17.3 | 1.00 ± 0.05 |
| `./checksum-d`       | 17.0 ± 0.2 |     16.6 |     17.5 | 1.05 ± 0.04 |
