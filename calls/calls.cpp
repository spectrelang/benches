#include <chrono>
#include <cstdint>
#include <cstdio>

constexpr int64_t ITERATIONS = 10'000'000;

static inline int64_t mix(int64_t a, int64_t b, int64_t c) {
    return (a * 31 + b * 17 - c * 13) ^ ((a + b) << 3);
}

int main() {
    int64_t checksum = 0;

    auto start = std::chrono::high_resolution_clock::now();
    for (int64_t i = 0; i < ITERATIONS; i++) {
        int64_t a = i % 997;
        int64_t b = i % 313;
        int64_t c = i % 127;
        checksum += mix(a, b, c);
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("C++: %lld ns/op\n", (long long)(elapsed / ITERATIONS));
    printf("Checksum: %lld\n", (long long)checksum);
}
