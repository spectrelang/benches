import std.stdio;
import core.time : MonoTime;

enum uint N = 2048;
enum uint ITERS = 100_000;

void main()
{
    uint[] a = new uint[N];
    uint[] b = new uint[N];
    uint[] c = new uint[N];

    foreach (i; 0 .. N)
    {
        a[i] = i % 97 + 1;
        b[i] = i % 89 + 3;
        c[i] = i % 83 + 5;
    }

    auto start = MonoTime.currTime();

    foreach (it; 0 .. ITERS)
    {
        foreach (i; 0 .. N)
        {
            c[i] = c[i] + a[i] * b[i];
        }
    }

    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    ulong sum = 0;
    foreach (v; c)
    {
        sum += v;
    }

    writefln("D: %d ns", elapsed);
    writefln("D: %d ns/pass", elapsed / ITERS);
    writefln("Checksum: %d", sum);
}
