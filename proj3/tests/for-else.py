for (a,b) in [(lambda x: x+2,3), (lambda x: x+3,4), (lambda x: x+" world!","hello")]:
  print(a(b))
else:
  print("we're done now")
