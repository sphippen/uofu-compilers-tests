import inspect
import functools

def coerce(f):
  """Creates a function that "coerces" its arguments using annotations.

  For any argument of the original function, the decorated version will call
  the annotation (like a callable) on arguments passed to that parameter.

  In this example, arguments passed to x will be "coerced" to int by calling
  int(<arg>) on the incoming value:
  @coerce
  def f(x : int) -> int:
    return str(x+3)

  f("3") # returns 6 (the int, not the string)
  f(x="3") # also works

  They also apply the values passed in through varargs and kwargs:
  @coerce
  def f(*x : str, **y : int):
    return x[0] + str(y["b"])

  f([1,2], 3, 4, a=2, b=3.4) # returns '[1, 2]3'
  """

  @functools.wraps(f)
  def wrapped(*old_pos, **old_kw):
    argspec = inspect.getfullargspec(f)
    def coerce_val(name,val):
      try:
        return argspec.annotations[name](val)
      except KeyError:
        return val
      except TypeError:
        return val

    coerced_pos = []
    coerced_kw = {}
    
    default_start_idx = len(argspec.args)
    if argspec.defaults != None:
      default_start_idx -= len(argspec.defaults)

    # Process f's positional arguments.
    for i,name in enumerate(argspec.args):
      given_as_pos = i < len(old_pos)
      given_as_kw = name in old_kw
      default_idx = i - default_start_idx

      if given_as_pos:
        coerced_pos.append(coerce_val(name, old_pos[i]))
      elif given_as_kw:
        coerced_pos.append(coerce_val(name, old_kw[name]))
        # We'll be passing this argument via the coerced_pos list, so we prevent
        # the code down below from putting this argument in the coerced_kw dict.
        del old_kw[name]
      elif default_idx >= 0:
        coerced_pos.append(coerce_val(name, argspec.defaults[default_idx]))
      else:
        # If this case runs, the call to f is guaranteed to cause an error (missing arguments).
        # The Python error about missing arguments is informative, so this is desirable.
        pass

    # Add any leftover positional arguments.
    coerced_pos.extend((coerce_val(argspec.varargs, val) for val in old_pos[len(argspec.args):]))
    
    # Process f's keyword arguments.
    for name in argspec.kwonlyargs:
      given_as_kw = name in old_kw
      if name in old_kw:
        coerced_kw[name] = coerce_val(name, old_kw[name])
        del old_kw[name]
      elif argspec.kwonlydefaults != None and name in argspec.kwonlydefaults:
        coerced_kw[name] = coerce_val(name, argspec.kwonlydefaults[name])
      else:
        # If this case runs, the call to f is guaranteed to cause an error (missing arguments).
        # The Python error about missing arguments is informative, so this is desirable.
        pass

    # Process any leftover keyword arguments
    coerced_kw.update({name: coerce_val(argspec.varkw, val) for name,val in old_kw.items()})

    return coerce_val("return", f(*coerced_pos, **coerced_kw))

  return wrapped

if __name__ == "__main__":
  @coerce
  def f(x : int = "42", *a : int, y : str = "not", z : 3, **kw : str) -> list:
    print(repr(x), repr(a), repr(y), repr(z), repr(kw))
    return (x for x in [2,3,4,5])

  # It works!
  print(repr(f(2, "3", "4", 5, z="hello", b=[1,2])))

# Program output:
#
# 2 (3, 4, 5) 'not' 'hello' {'b': '[1, 2]'}
# [2, 3, 4, 5]
#
# (First line is from the print statement inside f, second line is from the print statement on the outside)
