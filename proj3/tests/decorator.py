def decorator(func):
    def wrapped():
        return "from decorator!"
    return wrapped

@decorator
def decorated():
    return "from decorated"

print(decorated())
