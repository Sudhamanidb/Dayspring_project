# 1.Reverse without dynamic input
str="sudhamani"
rev=str.reverse
puts rev

# 2. Reverce with dynamic input

str1 = gets.chomp
def reverse1(a)
    rev1= a.reverse 
    puts rev1
end
puts reverse1(str1)

# 3. Palindrom

def Palindrom(b)
    rev2 = b.reverse
    if rev2 == b 
        "it is palindrom"
    else
        "not a palindrom"
    end
end

puts Palindrom(str)

# 4. factorial

num = gets.chomp.to_i
count = 0

def factorial(n, count)
  fact = 1
  if n == 0
    return n
  end
  while count < n do
    count += 1
    fact *= count
  end
  fact
end

puts factorial(num, count)

