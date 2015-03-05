def _1(): pass
def _2():
    def _2a():
        def _2b():
            def _2c():
                def _2e():
                    try:
                        a = b
                    except Foo:
                        a = 1
                    return a
                return _2e(a)
            return _2c(a)
        return _2b(a)
    return _2b(a)
