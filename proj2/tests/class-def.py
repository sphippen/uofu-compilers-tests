class _1: pass
class _2(): pass
class _3(First): pass
class _4(First,): pass
class _5(First, Second, Third): pass
class _6(First, Second, Third,): pass
class _7(First, *Second): pass
class _8(First, Second=foo, Third=bar): pass
class _9(First=foo, *Second, Third=quux, **Fourth): pass
class _10(**First): pass
class _11(*First, second=foo, Third=bar, **Fifth): pass
class _12(*First): pass
class _13(lowercase): pass
class _14(PreFirst, First=foo, *Second, Third=quux, **Fourth): pass

class _15(PreFirst, First=foo, *Second, Third=quux, **Fourth):
    a = 1
    b = 2
    c = 3
    a * b * c

@_16d
class _16: pass

@_17d.a.b.c
class _17: pass

@_18d(First)
class _18: pass

@_19d(First,)
class _19: pass

@_20d(First, Second, Third)
class _20: pass

@_21d(PreFirst, First=foo, *second, third=quux, **fourth)
class _21: pass

@_22d.a.b.c(PreFirst, First=foo, *second, third=quux, **fourth)
class _22: pass

@_23d1
@_23d2.a.b.c(PreFirst, First=foo, *second, third=quux, **fourth)
@_23_rax(first)
class _23: pass

@_24d1
@_24d2.a.b.c(PreFirst, First=foo, *second, third=quux, **fourth)
class _24(PreFirst, First=foo, *Second, Third=quux, **Fourth):
    a = 1
    b = 2
    c = 3
    a * b * c
