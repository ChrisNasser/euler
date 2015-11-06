require_relative '../lib/matrix'

m = Euler::Matrix.sum_block(3) { |n| n ** 2 }
puts m.solve!
