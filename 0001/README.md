# First attempt: 2 coprime numbers

File: sum-of-2-coprimes.rb

For this example, I decided to take advantage of [triangular numbers](https://en.wikipedia.org/wiki/Triangular_number).
In particular,

    1 + 2 + 3 .. n = (n * (n + 1)) / 2

We can use that to find the sum of multiples of some number too.

      3 + 6 + 9 .. n
    = 3 * (1 + 2 + 3 .. n/3)
    = 3 * (n/3 * (n/3 - 1)) / 2

Which gives us the sum of multiples of 3 in constant time. Let us define

    triSum(m, n) = m * (n/m * (n/m - 1)) / 2

where m is the multiple to sum, and n is the highest number to add. Then the answer is

    triSum(3, 999) + triSum(5, 999) - triSum(3 * 5, 999)

We subtract `triSum(3 * 5, 999)` because without it, we're double-counting numbers that
are multiples of both 3 and 5. This technique works for any two coprime numbers.

# Second attempt: Any two numbers

File: sum-of-2.rb

We only need to make one small change to the algorithm for this:

    triSum(a, lim) + triSum(b, lim) - triSum(lcm(a, b), lim)

Unfortunately, lcm is not a constant-time operation. Assuming that we use the equation
`lcm(a, b) = a * b / gcd(a, b)`, and use Euclid's method to find the gcd, the runtime
becomes O(log(digits(max(a, b)))), where digits(n) = number of digits in n. I believe
that works out to O(log(log(max(a, b)))).

# Third attempt: Any amount of numbers

Given a list of numbers n1, n2, n3 .. nM, find the sum of all multiples of n1 .. nM < limit.

After some experimentation, I believe the algorithm is:

    max = limit - 1
    sum = 0

    for i = 1 .. n
        for j = 1 .. n - i + 1
    		subsum = triSum(lcm(i .. j), max)
    		if j is odd,  sum += subsum
    		if j is even, sum -= subsum
    	end
    end

but I gave up at this point, because coding and testing that gets pretty tedious.
