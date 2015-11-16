module Euler
	class Primes
		@@primes = [2]

		# Find the nth prime
		def self.find_nth(n)
			puts "Finding #{n}th prime"
			return @@primes[n - 1] if @@primes.size >= n
			return self.find { |prime, size| size < n }[-1]
		end

		# Find all primes below n
		def self.find_below(n)
			if @@primes[-1] >= n
				# Binary search
				low = 0
				high = @@primes.size - 1
				return @@primes[0] if high == low

				until low + 1 == high or low == high
					mid = (low + high) / 2

					if @@primes[mid] < n
						low = mid
					else
						high = mid
					end
				end

				return @@primes[0 .. low]
			else
				# -2 because find needs to find one prime >= n
				# in order to terminate
				return self.find { |prime, size| prime < n }[0 .. -2]
			end
		end

		# Takes a block for when to stop termination
		def self.find
			low = @@primes[-1]
			high = 1000000
			increment = high
			high += increment while high <= low

			# candidates[n] == true if n is prime
			candidates = [true] * (high + 1)
			candidates[0] = false
			candidates[1] = false

			while yield(@@primes[-1], @@primes.size)
				prime = @@primes[-1]

				# Do the sieve
				mod = low % prime
				min = mod == 0 ? low : low + prime - (low % prime)
				min.step(high, prime) do |c|
					candidates[c] = false
				end

				# Find the next prime - it'll be the first true candidate
				# after the current prime
				found = false
				while prime <= high
					prime += 1

					if candidates[prime]
						@@primes << prime
						found = true
						break
					end
				end

				# If no prime found, extend the list of candidates
				unless found
					low = candidates.size
					high += increment
					# FIXME: With a bit of cleverness, we can replace the candidate array
					# instead of appending to it.
					candidates += [true] * increment

					# FIXME: Don't need to do the last prime, we'll get it
					# next iteration
					@@primes.each do |p|
						mod = low % p
						min = mod == 0 ? low : low + p - mod

						min.step(high, p) do |c|
							candidates[c] = false
						end
					end
				end
			end

			return @@primes
		end
	end
end
