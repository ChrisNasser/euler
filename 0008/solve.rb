number = IO.read(ARGV[0]).gsub(/\D/, '')
size = ARGV[1].to_i

parts = number.split('0')
largest = 0

parts.each do |part|
	next if part.size < size
	digits = part.split('').map { |n| n.to_i }

	product = digits[0 .. (size - 1)].reduce(:*)
	largest = product if product > largest

	size.upto(part.size - 1) do |i|
		product = product * digits[i] / digits[i - size]
		largest = product if product > largest
	end
end

puts largest
