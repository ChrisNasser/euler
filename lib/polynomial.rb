module Euler
	class Polynomial
		def initialize(coeffs, order=:ltr)
			coeffs = coeffs.reverse if order == :ltr
			@coeffs = coeffs
		end

		def solve(n)
			ans = coeffs[0]

			1.upto(coeffs.size - 1) do |c|
				ans += coeffs[c] * (n ** c)
			end

			return ans
		end

		def to_s
			parts = @coeffs[0] == 0 ? [] : [@coeffs[0]]
			parts.unshift("#{@coeffs[1]}x") unless @coeffs[1] == 0

			2.upto(@coeffs.size - 1) do |c|
				next if @coeffs[c] == 0
				parts.unshift("#{@coeffs[c]}x^#{c}")
			end

			return parts.join(' + ')
		end
	end
end
