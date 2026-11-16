#include <chrono>
#include <cstdint>
#include <cstdio>

constexpr uint64_t N = 2048;
constexpr uint64_t ITERS = 100000;

int main() {
    auto *a = new uint32_t[N];
    auto *b = new uint32_t[N];
    auto *c = new uint32_t[N];

    for (uint64_t i = 0; i < N; i++) {
        a[i] = static_cast<uint32_t>(i % 97 + 1);
        b[i] = static_cast<uint32_t>(i % 89 + 3);
        c[i] = static_cast<uint32_t>(i % 83 + 5);
    }

    auto start = std::chrono::high_resolution_clock::now();

    for (uint64_t it = 0; it < ITERS; it++) {
        for (uint64_t i = 0; i < N; i++) {
            c[i] = c[i] + a[i] * b[i];
        }
    }

    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    uint64_t sum = 0;
    for (uint64_t i = 0; i < N; i++) {
        sum += c[i];
    }

    printf("C++: %lld ns\n", static_cast<long long>(elapsed));
    printf("C++: %lld ns/pass\n", static_cast<long long>(elapsed / ITERS));
    printf("Checksum: %llu\n", static_cast<unsigned long long>(sum));

    delete[] a;
    delete[] b;
    delete[] c;
}
