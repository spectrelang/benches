#include <cstdint>
#include <cstdio>

static const int64_t A = 1234567;
static const int64_t B = 7654321;
static const uint64_t ROUNDS = 6000000;

static int64_t step(int64_t x, int64_t y) {
    int64_t a = x * 3 + y * 5;
    int64_t b = a % 1000003;
    int64_t c = (b * b) % 1000009;
    return c + a % 97;
}

int main() {
    uint64_t acc = 0;
    for (uint64_t i = 0; i < ROUNDS; i++) {
        acc = (acc * 1099511628211ULL + (uint64_t)step(A, B)) ^ (acc >> 7);
    }
    std::printf("%lld\n", (long long)(acc & 0x7fffffffULL));
    return 0;
}
