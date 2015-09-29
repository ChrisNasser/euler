#!/usr/bin/ruby

def tri(n)
	(n * (n + 1)) / 2
end

def solve(n1, n2, limit)
	both = n1 * n2
	n1 * tri(limit / n1) + n2 * tri(limit / n2) - both * tri(limit / both)
end

n1, n2, limit = ARGV.map { |n| n.to_i }
puts solve(n1, n2, limit - 1)
