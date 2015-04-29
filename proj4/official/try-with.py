class ctxt:
  def __enter__(self):
     print("entered")

  def __exit__(self,*args):
     print("exit")


try:
  with ctxt() as o:
    print("in process")
    raise Error("except")
except:
  print("got exception")

