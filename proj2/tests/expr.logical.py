a or b
a and b
a or b and c
a or b and not c
not a or b and c
a or b > c == d
a == c or d == e
a >= c or d not in ([1,2] if e == f else [3,4])
c < d
a <= d or a <= f

# pysx barfs on this
#c <> e

a != (b or d)
c in (yield 3,4,5)
a is not d or c == d
