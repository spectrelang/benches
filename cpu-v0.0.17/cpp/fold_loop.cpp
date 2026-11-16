#include <cstdint>
#include <cstdio>

static const uint64_t N = 50000;
static const uint64_t ROUNDS = 400;

static uint64_t sum_to(uint64_t n) {
    uint64_t s = 0;
    for (uint64_t i = 0; i < n; i++) s += (i * 7) % 13;
    return s;
}

int main() {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc + sum_to(N)) ^ (acc >> 1);
    }
    std::printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
