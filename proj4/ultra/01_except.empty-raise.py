class eA(BaseException): ""
class eB(BaseException): ""

try:
    try:
        raise eA()
    except BaseException as e:
        def baz():
            raise
        try:
            raise eB()
        except BaseException as e2:
            baz()
except eA:
    print("Outer caught eA")
except eB:
    print("Outer caught eB")
