import contextlib

@contextlib.contextmanager
def cntxt(before, yields, after):
    print(before)
    yield yields
    print(after)

with cntxt("before ctxt", "in with", "after ctxt") as foo:
    print(foo)

with cntxt("before ctnxt B", "in with B", "after ctxt B"):
    print("no binding")
