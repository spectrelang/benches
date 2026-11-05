#include <chrono>
#include <cstdint>
#include <cstdio>

constexpr int64_t ITERATIONS = 10'000'000;
constexpr int64_t ARRAY_SIZE = 1024;

int main() {
    int32_t data[ARRAY_SIZE];
    for (int64_t i = 0; i < ARRAY_SIZE; i++) {
        data[i] = (int32_t)((i * 17 + 13) % 997);
    }

    int64_t checksum = 0;

    auto start = std::chrono::high_resolution_clock::now();
    for (int64_t i = 0; i < ITERATIONS; i++) {
        int64_t idx = (i * 31) % ARRAY_SIZE;
        int32_t x = data[idx];

        if ((x & 1) == 0) {
            checksum += (int64_t)x * 3 + i % 97;
        } else {
            checksum -= (int64_t)x * 2 - i % 53;
        }

        checksum ^= (checksum << 7) | (checksum >> 3);
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("C++: %lld ns/op\n", (long long)(elapsed / ITERATIONS));
    printf("Checksum: %lld\n", (long long)checksum);
}
