#include <stdint.h>
#include <stdio.h>

#define ROUNDS 4000000ULL
static const uint64_t FIB = 46368ULL;

int main(void) {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + FIB) ^ (acc >> 7);
    }
    printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
