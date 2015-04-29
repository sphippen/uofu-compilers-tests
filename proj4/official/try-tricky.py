class AExn(BaseException):
  pass

def aexn(): return AExn

try:
  raise AExn() 
except aexn() as a:
  print("excepted")
