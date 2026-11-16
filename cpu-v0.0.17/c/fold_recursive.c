#include <stdint.h>
#include <stdio.h>

#define ROUNDS 4000000ULL

static uint64_t fib(uint64_t n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

int main(void) {
    uint64_t fibv = fib(24);
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + fibv) ^ (acc >> 7);
    }
    printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
