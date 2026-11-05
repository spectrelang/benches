import std.stdio;
import std.algorithm.sorting : sort;
import core.time : MonoTime;

enum N = 5_000_000;

void main()
{
    ulong[] xs;
    xs.reserve(N);
    ulong seed = 123456789;
    foreach (i; 0 .. N)
    {
        seed = seed * 6364136223846793005UL + 1442695040888963407UL;
        xs ~= seed & 0xffffffff;
    }

    auto start = MonoTime.currTime();
    xs.sort();
    ulong checksum = 0;
    foreach (v; xs)
        checksum ^= v;
    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("Checksum: %d", checksum);
}
