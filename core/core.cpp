#include <chrono>
#include <cstdint>
#include <cstdio>

constexpr uint64_t MIX_ITERATIONS = 40'000'000;
constexpr uint64_t COLLATZ_LIMIT = 1'000'000;
constexpr uint64_t FIB_N = 35;

static inline uint64_t mix(uint64_t x) {
    uint64_t y = x;
    y = (y ^ (y >> 30)) * 0xbf58476d1ce4e5b9ULL;
    y = (y ^ (y >> 27)) * 0x94d049bb133111ebULL;
    return y ^ (y >> 31);
}

static uint64_t collatz(uint64_t n) {
    uint64_t steps = 0;
    for (;;) {
        if (n == 1) break;
        if ((n & 1) == 0) {
            n >>= 1;
        } else {
            n = n * 3 + 1;
        }
        steps++;
    }
    return steps;
}

__attribute__((noinline)) static uint64_t fib(uint64_t n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();
    uint64_t checksum = 0x123456789abcdefULL;

    for (uint64_t i = 0; i < MIX_ITERATIONS; i++) {
        checksum = mix(checksum + i);
    }

    for (uint64_t n = 1; n < COLLATZ_LIMIT; n++) {
        checksum += collatz(n);
    }

    checksum += fib(FIB_N);
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("C++: %lld ns/op\n", (long long)(elapsed / (MIX_ITERATIONS + COLLATZ_LIMIT)));
    printf("Checksum: %llu\n", (unsigned long long)checksum);
}
