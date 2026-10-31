
import std.stdio;
import core.time : MonoTime;

enum iterations = 10_000_000;

long mix(long a, long b, long c)
{
    return (a * 31 + b * 17 - c * 13) ^ ((a + b) << 3);
}

void main()
{
    long checksum = 0;

    auto start = MonoTime.currTime();

    foreach (i; 0 .. iterations)
    {
        long a = cast(long)(i % 997);
        long b = cast(long)(i % 313);
        long c = cast(long)(i % 127);

        checksum += mix(a, b, c);
    }

    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("D: %d ns/op", elapsed / iterations);
    writefln("Checksum: %d", checksum);
}
