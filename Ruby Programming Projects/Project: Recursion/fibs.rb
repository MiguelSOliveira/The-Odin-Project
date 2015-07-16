def fibs_non_recursive(n)
  a, b, c = 1, 1, 1
  0.upto(n) do |i|
    c = a + b
    a, b = b, c
    puts c
  end
end

def fibs_recursive(n)
  return 1 if n == 1 || n == 0
  return fibs_recursive(n-1) + fibs_recursive(n-2)
end

fibs_non_recursive(10)
puts fibs_recursive(35)
