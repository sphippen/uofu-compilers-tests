

def f():
   yield from [1,2,3]


for x in f():
  print(x)
  
