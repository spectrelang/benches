#include <chrono>
#include <cstdint>
#include <cstdio>
#include <string>
#include <nlohmann/json.hpp>

int main() {
    const size_t N = 300000;
    const size_t ITERATIONS = 20;

    std::string input;
    input.reserve(N * 8);
    input.push_back('[');
    for (size_t i = 0; i < N; i++) {
        if (i > 0) input.push_back(',');
        input += std::to_string(i);
    }
    input.push_back(']');

    auto value = nlohmann::json::parse(input);

    auto start = std::chrono::high_resolution_clock::now();
    int64_t checksum = 0;
    for (size_t k = 0; k < ITERATIONS; k++) {
        std::string out = value.dump();
        checksum += (int64_t)out.size();
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("Checksum: %lld\n", (long long)checksum);
}
