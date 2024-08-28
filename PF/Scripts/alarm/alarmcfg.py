def filter_latest_name(str):
  strarr=str.split('\r\n')
  s1=''
  for i in strarr:
    if i=='':
      break
    s1=i.strip()
  return s1
  
def give_build_number(s:str):
  if s.startswith('(('):
    return s.split("((")[1].split("))")[0]
  return s.split(":")[1].split("((")[1].split("))")[0]
 
def filter_name(str):
  strarr=str.split('\r\n')
  #print(strarr)
  return strarr[0].strip()

def filter_interfaces(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip())
  topotp = list(set(topotp))
  return topotp