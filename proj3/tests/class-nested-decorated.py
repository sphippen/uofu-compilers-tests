class A:
    def decorator(fun):
        return lambda: "decorated!"

    @decorator
    class B:
        class C:
            c = 10

    something = "something"

print(A.something)
print(A.B())
