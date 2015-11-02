# If n <= high / 2, then 2n is in the set, and n can be eliminated
# Otherwise, n is not a factor of anything in the set, and must be considered

high = ARGV[0].to_i
low = high / 2 + 1
puts (low .. high).reduce(:lcm)
