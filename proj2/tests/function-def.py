def _1(): pass
def _2(a): pass
def _3(a : int): pass
def _4(a,): pass
def _5(a : int = b): pass
def _6(a : int = b,): pass
def _7(a : int = b, q : bar = c): pass
def _8(a = b, q = c): pass
def _9(q, r, x : str, a : foo = b, l = m, n = o): pass
def _9(q, r, x : str, a : foo = b, l = m, n = o,): pass
def _10(a, *, l): pass
def _11(a, *b): pass
def _12(a, *b : int): pass
def _13(a = quux, *b : int): pass
def _14(a, *, foo = quux): pass
def _15(a, *, foo : int = quux): pass
def _16(a, *rax : baz, foo : int = quux): pass
def _17(a, *rax : baz, foo : int = quux, d, e = f, g : str): pass
def _18(a, *rax : baz, foo : int = quux, d, e = f, g : str, **blah): pass
def _19(a, *rax : baz, foo : int = quux, d, e = f, g : str, **blah : int): pass
def _20(a, *baz : quux **what): pass
def _21(a, **bar): pass
def _22(**bar): pass
def _24(*, a): pass
def _25(*, a : int = b): pass
def _26(*, a : int = b, **foo): pass
def _27(a, d : int, b = c, e : int = f, *g : int, h = i, j : int = k, l, m : int, **n : int): pass

def _28(a, d : int, b = c, e : int = f, *g : int, h = i, j : int = k, l, m : int, **n : int):
    a = 1
    b = 2
    c = 3
    a, b, c = foo(lambda x: y, z) + q

@_29d
def _29(): pass

@_30d.a.b.c
def _30(): pass

@_31d(a)
def _31(): pass

@_32d(a, d, b = c, e = f, *g, h = i, j= k, **n)
def _32(): pass

@_33d.a.b.c(a, d, b = c, e = f, *g, h = i, j= k, **n)
def _33(): pass

@_34d1
@_34d2.a.b.c
@_34d3(a)
@_34d4.a.b.c(a, d, b = c, e = f, *g, h = i, j= k, **n)
def _34(a, d : int, b = c, e : int = f, *g : int, h = i, j : int = k, l, m : int, **n : int):
    a = 1
    b = 2
    c = 3
    a, b, c = foo(lambda x: y, z) + q
