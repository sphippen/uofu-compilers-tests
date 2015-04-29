def id(of):
    return lambda: of

locked = lambda a, b, c: a() and b() or c()

foo = lambda: locked(*map(id, (0, 1, False)))
bar = lambda: locked(*map(id, (1, 1, [])))
print(foo())
print(bar())

quux = (foo() or bar()) or foo() and bar()
print(quux)
