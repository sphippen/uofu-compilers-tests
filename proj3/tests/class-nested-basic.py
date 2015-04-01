class A:
    a = "first"
    class B:
        b = "second"
        class C:
            c = "third"
print(A.a)
print(A.B.b)
print(A.B.C.c)
