print("before try")
try:
    print("before exn")
    raise RuntimeError("err")
    print("after exn")
except RuntimeError as foo:
    print("in exn")
    print(foo.args)
print("after try")
