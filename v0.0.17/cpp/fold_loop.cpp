#include <cstdint>
#include <cstdio>

constexpr uint64_t N = 50000;
constexpr uint64_t ROUNDS = 400;

constexpr uint64_t sum_to(uint64_t n) {
    uint64_t s = 0;
    for (uint64_t i = 0; i < n; i++) s += (i * 7) % 13;
    return s;
}

constexpr uint64_t SUM = sum_to(N);

int main() {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc + SUM) ^ (acc >> 1);
    }
    std::printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
