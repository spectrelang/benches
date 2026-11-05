#include <chrono>
#include <cstdint>
#include <cstdio>
#include <unordered_map>

int main() {
    const uint64_t KEY_COUNT = 50000;
    const uint64_t OPERATIONS = 5000000;

    std::unordered_map<uint64_t, uint64_t> map;
    map.reserve(131072);

    auto start = std::chrono::high_resolution_clock::now();
    for (uint64_t i = 0; i < OPERATIONS; i++) {
        map[i % KEY_COUNT]++;
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    uint64_t checksum = 0;
    for (uint64_t i = 0; i < KEY_COUNT; i++) {
        auto it = map.find(i);
        if (it != map.end()) {
            checksum += it->second;
        }
    }

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("Checksum: %llu\n", (unsigned long long)checksum);
}
