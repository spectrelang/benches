N = 50_000_i64
ROUNDS = 400

def sum_to(n : Int64) : Int64
  sum = 0_i64
  i = 0_i64
  while i < n
    sum &+= (i &* 7_i64) % 13_i64
    i += 1
  end
  sum
end

acc = 0_u64
r = 0
while r < ROUNDS
  acc = (acc &+ sum_to(N).to_u64) ^ (acc >> 1)
  r += 1
end
puts(acc & 0x7fffffff_u64)
