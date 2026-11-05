import std.json;
import std.stdio;
import std.conv : to;
import core.time : MonoTime;

enum N = 300_000;
enum ITERATIONS = 20;

void main()
{
    string input;
    input.reserve(N * 8);
    input ~= "[";
    foreach (i; 0 .. N)
    {
        if (i > 0)
            input ~= ",";
        input ~= i.to!string;
    }
    input ~= "]";

    auto doc = parseJSON(input);

    auto start = MonoTime.currTime();
    long checksum = 0;
    foreach (_; 0 .. ITERATIONS)
    {
        string encoded = toJSON(doc);
        checksum += cast(long)encoded.length;
    }
    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("Checksum: %d", checksum);
}
