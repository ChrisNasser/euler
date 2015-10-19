require_relative 'p4-lib'

def has_factors?(num, fact_max, fact_min)
	fact_max.downto(fact_min) do |factor|
		next if num % factor != 0

		remainder = num / factor
		return false if remainder > fact_max
		return true if remainder >= fact_min
	end

	return false
end

def solve(n, base=10)
	pal_max = (base ** n - 1) ** 2
	pal_max_size = num_digits(pal_max)
	fact_max = (base ** n - 1)
	fact_min = base ** (n - 1)

	pal_max_size.downto(1) do |size|
		left_size = size / 2

		(base ** (left_size) - 1).downto(base ** (left_size - 1)) do |part|
			palindrome = 0

			if (size % 2 == 0)
				palindrome = part * (base ** left_size) + reverse(part)
				return palindrome if has_factors?(palindrome, fact_max, fact_min)
			else
				9.downto(0) do |middle|
					palindrome = part * (base ** (left_size + 1)) \
						+ middle * (base ** left_size) \
						+ reverse(part)
					return palindrome if has_factors?(palindrome, fact_max, fact_min)
				end
			end
		end
	end

	return nil
end

input = ARGV[0].to_i
puts solve(input)
