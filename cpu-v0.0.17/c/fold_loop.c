#include <stdint.h>
#include <stdio.h>

#define N 50000ULL
#define ROUNDS 400ULL

static uint64_t sum_to(uint64_t n) {
    uint64_t sum = 0;
    for (uint64_t i = 0; i < n; i++) {
        sum += (i * 7) % 13;
    }
    return sum;
}

int main(void) {
    uint64_t acc = 0;
    for (uint64_t r = 0; r < ROUNDS; r++) {
        acc = (acc + sum_to(N)) ^ (acc >> 1);
    }
    printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
