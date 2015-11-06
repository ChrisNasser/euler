range = (1 .. ARGV[0].to_i)
puts range.reduce(:+) ** 2 - range.map { |n| n ** 2 }.reduce(:+)
