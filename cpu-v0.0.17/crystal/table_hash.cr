SIZE = 4096
PASSES = 1024

table = Array(UInt64).new(SIZE, 0_u64)

def cell(i : UInt64) : UInt64
  x = i &* 0x9e3779b97f4a7c15_u64 &+ 1_u64
  j = 0
  while j < 128
    x ^= x >> 12
    x ^= x << 25
    x ^= x >> 27
    x &*= 2685821657736338717_u64
    j += 1
  end
  x
end

i = 0
while i < SIZE
  table[i] = cell(i.to_u64)
  i += 1
end

h = 14695981039346656037_u64
p = 0
while p < PASSES
  i = 0
  while i < SIZE
    h = (h ^ table[i]) &* 1099511628211_u64
    i += 1
  end
  p += 1
end
puts(h & 0x7fffffff_u64)
