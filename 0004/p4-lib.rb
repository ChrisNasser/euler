def num_digits(num, base=10)
	return Math.log(num, base).floor + 1
end

def digit(num, dig, base=10)
	return (num / base ** (dig - 1)) % base
end

def palindrome?(num, base=10)
	size = num_digits(num)

	1.upto(size / 2) do |d|
		return false unless digit(num, d) == digit(num, size - d + 1)
	end

	return true
end

def reverse(num, base=10)
	size = num_digits(num, base)

	rev = 0
	1.upto(size) do |d|
		dig = digit(num, d)
		rev += dig * base ** (size - d)
	end

	return rev
end
