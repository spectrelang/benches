#include <stdint.h>
#include <stdio.h>

#define ROUNDS 4000000ULL
static const uint64_t MIX = 7065331290632341489ULL;
static const uint64_t COLL = 77ULL;

int main(void) {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + MIX) ^ COLL;
    }
    printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
