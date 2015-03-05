class One: pass
class Two(): pass
class Three(First): pass
class Four(First,): pass
class Five(First, Second, Third): pass
class Six(First, Second, Third,): pass
class Seven(First, *Second): pass
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

@_23d.a.b.c(PreFirst, First=foo, *second, third=quux, **fourth)
class _23(PreFirst, First=foo, *Second, Third=quux, **Fourth):
    a = 1
    b = 2
    c = 3
    a * b * c
