#include <chrono>
#include <cstdint>
#include <cstdio>
#include <nlohmann/json.hpp>

constexpr int64_t ITERATIONS = 1'000'000;

const char *INPUT = R"({
 "name":"Spectre",
 "version":12,
 "active":true,
 "values":[1,2,3,4,5,6,7,8,9,10]
})";

int main() {
    int64_t checksum = 0;

    auto start = std::chrono::high_resolution_clock::now();
    for (int64_t i = 0; i < ITERATIONS; i++) {
        auto root = nlohmann::json::parse(INPUT);
        if (root.is_object()) {
            auto version = root.find("version");
            if (version != root.end() && version->is_number_integer()) {
                checksum += version->get<int64_t>();
            }
            auto active = root.find("active");
            if (active != root.end() && active->is_boolean() && active->get<bool>()) {
                checksum += 1;
            }
        }
    }
    auto elapsed = std::chrono::duration_cast<std::chrono::nanoseconds>(
        std::chrono::high_resolution_clock::now() - start).count();

    printf("C++: %lld ns\n", (long long)elapsed);
    printf("C++: %lld ns/op\n", (long long)(elapsed / ITERATIONS));
    printf("Checksum: %lld\n", (long long)checksum);
}
