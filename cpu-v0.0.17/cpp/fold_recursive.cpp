#include <cstdint>
#include <cstdio>

static const uint64_t ROUNDS = 4000000;

static uint64_t fib(uint64_t n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
}

int main() {
    uint64_t fibv = fib(24);
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + fibv) ^ (acc >> 7);
    }
    std::printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
