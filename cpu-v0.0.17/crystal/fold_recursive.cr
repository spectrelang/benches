ROUNDS = 4_000_000

def fib(n : Int64) : Int64
  return n if n < 2
  fib(n - 1) + fib(n - 2)
end

fibv = fib(24).to_u64
acc = 0_u64
i = 0
while i < ROUNDS
  acc = (acc &* 1099511628211_u64 &+ fibv) ^ (acc >> 7)
  i += 1
end
puts(acc & 0x7fffffff_u64)
