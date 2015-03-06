a = b
a, b = c
a, = c
a, b, = c
a = yield
a = yield from baz
a, b, c = yield
a, b, c = yield from baz
a = foo(10 * f + 22)
a, b, *c = [1, 2, 3, 4, 5]
*a, *b, *foo, *x = 12
*_ = 12

a = b = 3
a = *b = c = 3*x
a = *b = c = d = *f = e = 10
*a = b = foo(3)[21]
a,b = *c = d = 3
*c = a,b = c,d,e = 10

a = b or c, d or e
a,b = c = d = e or f, g or h
