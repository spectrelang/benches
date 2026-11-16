#include <stdint.h>
#include <stdio.h>

#define ROUNDS 400ULL
static const uint64_t SUM = 299995ULL;

int main(void) {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc + SUM) ^ (acc >> 1);
    }
    printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
