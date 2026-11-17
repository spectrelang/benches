A = 1234567_i64
B = 7654321_i64
ROUNDS = 6_000_000

def step(x : Int64, y : Int64) : Int64
  a = x * 3 + y * 5
  b = a % 1000003
  c = (b * b) % 1000009
  c + a % 97
end

acc = 0_u64
i = 0
while i < ROUNDS
  acc = (acc &* 1099511628211_u64 &+ step(A, B).to_u64) ^ (acc >> 7)
  i += 1
end
puts(acc & 0x7fffffff_u64)
