import std.stdio;
import core.time : MonoTime;

enum iterations = 10_000_000;
enum arraySize = 1024;

void main()
{
    int[arraySize] data;

    foreach (i; 0 .. arraySize)
        data[i] = cast(int)((i * 17 + 13) % 997);

    long checksum = 0;

    auto start = MonoTime.currTime();

    foreach (i; 0 .. iterations)
    {
        size_t idx = (i * 31) % arraySize;
        int x = data[idx];

        if ((x & 1) == 0)
            checksum += x * 3 + cast(long)i % 97;
        else
            checksum -= x * 2 - cast(long)i % 53;

        checksum ^= (checksum << 7) | (checksum >> 3);
    }

    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("D: %d ns/op", elapsed / iterations);
    writefln("Checksum: %d", checksum);
}
