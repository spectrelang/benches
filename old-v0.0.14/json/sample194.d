
import std.json;
import std.stdio;
import core.time : MonoTime;

enum iterations = 1_000_000;

void main()
{
    enum input = `{
        "name":"Spectre",
        "version":12,
        "active":true,
        "values":[1,2,3,4,5,6,7,8,9,10]
    }`;

    auto start = MonoTime.currTime();

    foreach (i; 0 .. iterations)
    {
        auto doc = parseJSON(input);

        if (doc.type == JSONType.object)
        {
            auto ver = doc["version"].integer;
            auto active = doc["active"].boolean;

            // Prevent the compiler from treating the queries as dead code.
            assert(ver == 12);
            assert(active);
        }
    }

    auto elapsed = (MonoTime.currTime() - start).total!"nsecs";

    writefln("D: %d ns", elapsed);
    writefln("D: %d ns/op", elapsed / iterations);
}
