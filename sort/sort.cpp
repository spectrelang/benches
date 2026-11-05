#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <vector>

int main() {
    const size_t N = 5000000;
    std::vector<uint64_t> xs;
    xs.reserve(N);
    uint64_t seed = 123456789;
    for (size_t i = 0; i < N; i++) {
        seed = seed * 6364136223846793005ULL + 1442695040888963407ULL;
        xs.push_back(seed & 0xffffffffULL);
    }

    auto start = std::chrono::high_resolution_clock::now();
    std::sort(xs.begin(), xs.end());
    uint64_t checksum = 0;
    for (auto v : xs) {
        checksum ^= v;
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("Checksum: %llu\n", (unsigned long long)checksum);
}
