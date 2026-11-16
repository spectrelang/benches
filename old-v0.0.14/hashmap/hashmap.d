import std.stdio;
import core.time : MonoTime;

enum KEY_COUNT = 50_000;
enum OPERATIONS = 5_000_000;

void main()
{
    long[long] map;

    auto start = MonoTime.currTime();
    foreach (i; 0 .. OPERATIONS)
    {
        long key = cast(long)(i % KEY_COUNT);
        auto p = key in map;
        if (p is null)
            map[key] = 1;
        else
            (*p)++;
    }
    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    long checksum = 0;
    foreach (i; 0 .. KEY_COUNT)
    {
        auto p = cast(long)i in map;
        if (p !is null)
            checksum += *p;
    }

    writefln("D: %d ns", elapsed);
    writefln("Checksum: %d", checksum);
}
