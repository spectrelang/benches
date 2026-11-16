#include <cstdint>
#include <cstdio>

constexpr uint64_t SEED = 123456789;
constexpr uint64_t ROUNDS = 4000000;

constexpr uint64_t mix(uint64_t x) {
    x ^= x >> 13;
    x *= 1000003;
    x ^= x >> 7;
    x *= 2654435761;
    return x;
}

constexpr uint64_t collatz(uint64_t n) {
    uint64_t steps = 0;
    while (n != 1) {
        n = (n % 2 == 0) ? n / 2 : 3 * n + 1;
        steps++;
    }
    return steps;
}

constexpr uint64_t MIX = mix(SEED);
constexpr uint64_t COLL = collatz(SEED % 1000 + 1);

int main() {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + MIX) ^ COLL;
    }
    std::printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
