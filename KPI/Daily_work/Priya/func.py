import re

def sort_rstate(val):
  val= sorted(val, key=lambda x:(isinstance(x,str),x))
  print(val)