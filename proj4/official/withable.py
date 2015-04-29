class ctxt:
  def __enter__(self):
     print("entered")

  def __exit__(self,*args):
     print("exit")


with ctxt() as o:
  print("in process")

