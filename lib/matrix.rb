require 'mathn'

require_relative 'polynomial'

module Euler
	class Matrix
		def self.from_block(degree)
			input = []

			0.upto(degree) do |i|
				input << yield(i)
			end

			return self.from_sequence(input)
		end

		def self.sum_block(degree)
			input = [yield(0)]

			1.upto(degree) do |i|
				input << input[-1] + yield(i)
			end

			return self.from_sequence(input)
		end

		def self.from_sequence(sequence)
			grid = []

			0.upto(sequence.size - 1) do |r|
				row = []

				0.upto(sequence.size - 1) do |c|
					row[c] = (r + 1) ** c
				end

				row.reverse!
				row << sequence[r]
				grid << row
			end

			return self.new(grid, false)
		end

		def initialize(grid, dup=true)
			@grid = dup ? grid.dup : grid
		end

		def solve
			return dup.solve!
		end

		# Basic Gauss-Jordan elimination
		# FIXME: This fails if any of the diagonals becomes 0. Need to swap rows in that case.
		def solve!
			0.upto(@grid.size - 1) do |r|
				num = @grid[r][r]
				@grid[r][r] = 1

				(r + 1).upto(@grid[0].size - 1) do |c|
					@grid[r][c] /= num
				end

				(r + 1).upto(@grid.size - 1) do |r2|
					num2 = @grid[r2][r]
					@grid[r2][r] = 0

					(r + 1).upto(@grid[0].size - 1) do |c|
						@grid[r2][c] -= num2 * @grid[r][c]
					end
				end
			end

			(@grid.size - 1).downto(0) do |r|
				(r - 1).downto(0) do |r2|
					num = @grid[r2][r]
					@grid[r2][r] = 0
					@grid[r2][-1] -= @grid[r][-1] * num
				end
			end

			return Polynomial.new(@grid.map { |row| row[-1] })
		end
	end
end
