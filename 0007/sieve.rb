require_relative '../lib/primes'

puts Euler::Primes.find_nth(ARGV[0].to_i)
