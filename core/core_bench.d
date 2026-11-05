import std.stdio;
import core.time : MonoTime;

enum ulong MIX_ITERATIONS = 40_000_000UL;
enum ulong COLLATZ_LIMIT = 1_000_000UL;
enum ulong FIB_N = 35UL;

ulong mix(ulong x)
{
    ulong y = x;
    y = (y ^ (y >> 30)) * 0xbf58476d1ce4e5b9UL;
    y = (y ^ (y >> 27)) * 0x94d049bb133111ebUL;
    return y ^ (y >> 31);
}

ulong collatz(ulong n)
{
    ulong steps = 0;
    for (;;)
    {
        if (n == 1)
            break;
        if ((n & 1) == 0)
            n >>= 1;
        else
            n = n * 3 + 1;
        steps++;
    }
    return steps;
}

ulong fib(ulong n)
{
    if (n < 2)
        return n;
    return fib(n - 1) + fib(n - 2);
}

void main()
{
    auto start = MonoTime.currTime();
    ulong checksum = 0x123456789abcdefUL;

    foreach (ulong i; 0 .. MIX_ITERATIONS)
        checksum = mix(checksum + i);

    foreach (ulong n; 1 .. COLLATZ_LIMIT)
        checksum += collatz(n);

    checksum += fib(FIB_N);
    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("D: %d ns/op", elapsed / (MIX_ITERATIONS + COLLATZ_LIMIT));
    writefln("Checksum: %d", checksum);
}
