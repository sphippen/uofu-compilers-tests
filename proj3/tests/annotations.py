def fun(a : "ham", b : str, c : int, *star : list, book : tuple = (), **kw : float):
    return a, b, c, star, book, kw
print(fun.__annotations__)
