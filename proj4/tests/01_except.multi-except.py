import os

print("before try")
try:
    print("before raise")
    raise TypeError("something")
    print("after raise")
except AttributeError as e:
    print("in attribute error exn")
except RuntimeError:
    print("in runtime error")
except NotImplementedError as quux:
    print("in not implemented error")
except os.error:
    print("in os error alias")
except TypeError as foo:
    print("in type error", foo.args)
print("after try")
