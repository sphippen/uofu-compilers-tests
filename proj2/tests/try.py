try: pass
except: pass
except: pass
except: pass
else: pass
finally: pass

try: pass
finally: pass

try:
    try:
        try: pass
        except foo: pass
    except bar as quux:
        bar = 1
    except total:
        total = 1
    finally: blah
except: 
    pass
else:
    break
