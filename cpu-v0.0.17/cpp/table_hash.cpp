#include <array>
#include <cstdint>
#include <cstdio>

static const uint64_t SIZE = 4096;
static const uint64_t PASSES = 1024;

static uint64_t cell(uint64_t i) {
    uint64_t x = i * 0x9e3779b97f4a7c15ULL + 1;
    for (int j = 0; j < 128; j++) {
        x ^= x >> 12;
        x ^= x << 25;
        x ^= x >> 27;
        x *= 2685821657736338717ULL;
    }
    return x;
}

static std::array<uint64_t, SIZE> table;

static void fill_table() {
    for (uint64_t i = 0; i < SIZE; i++) table[i] = cell(i);
}

int main() {
    fill_table();
    uint64_t h = 14695981039346656037ULL;
    for (uint64_t p = 0; p < PASSES; p++) {
        for (uint64_t i = 0; i < SIZE; i++) {
            h = (h ^ table[i]) * 1099511628211ULL;
        }
    }
    std::printf("%lld\n", (long long)(h & 0x7fffffffULL));
    return 0;
}
