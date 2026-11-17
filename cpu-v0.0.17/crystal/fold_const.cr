SEED = 123456789_u64
ROUNDS = 4_000_000

def mix(x : UInt64) : UInt64
  v = x
  v ^= v >> 13
  v &*= 1000003_u64
  v ^= v >> 7
  v &*= 2654435761_u64
  v
end

def collatz(n : UInt64) : UInt64
  x = n
  steps = 0_u64
  while x != 1
    x = (x % 2 == 0) ? x // 2 : 3_u64 &* x &+ 1_u64
    steps &+= 1_u64
  end
  steps
end

acc = 0_u64
i = 0
while i < ROUNDS
  acc = (acc &* 1099511628211_u64 &+ mix(SEED)) ^ collatz(SEED % 1000_u64 &+ 1_u64)
  i += 1
end
puts(acc & 0x7fffffff_u64)
