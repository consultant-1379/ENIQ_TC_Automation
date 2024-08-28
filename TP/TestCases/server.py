import paramiko
import re
from datetime import datetime
from datetime import timedelta
def transfer_to_server(file, server:str,user:str,password:str):
  '''Takes filename to transfer, server name, username and password as input
  '''
  print(file)  
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
      ssh_client.connect(server,port,user,password)
      print('Connection established successfully')
      ssh_transfer=ssh_client.open_sftp()
      path=r'/eniq/home/dcuser/'
      #ssh_transfer.mkdir(path)
      print(f'Directory- {path} created')
      ssh_transfer.put(f'H://Downloads//{file}', f'{path}//{file}')
      print(f'File {file} transferred to {path} Successfully' )
      ssh_client.exec_command(f'mv {file}  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'unzip  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'cd  BT-FT_Script/ ')
      #ssh_client.exec_command(f'pwd')

  except Exception as e:
    print("Error is= ",e)
  finally:
      ssh_transfer.close()
      ssh_client.close()
      print('All Connections are Closed')

def filter_topotp_name(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      topotp.append(strarr[i].strip())
  topotp = list(set(topotp))
  return topotp

def filter_topotp(str):
  strarr=str.split('\r\n')
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      return strarr[i].strip()
  return " "

def filter_interface_name(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  topotp = list(set(topotp))
  return topotp

def filter_interfaces(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip())
  topotp = list(set(topotp))
  return topotp

def int_and_dim_name(dimpkg,str):
  strarr=str.split('\r\n')
  topotp=[]
  topotp.append(dimpkg[0])
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  return topotp

def filter_intf_name(tpname:str,str,server:str,user:str,password:str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INTF') or strarr[i].startswith(' DIM') ):
      topotp.append(strarr[i].strip())
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  topotp.append(tpname)
  topotp = list(set(topotp))
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_transfer=ssh_client.open_sftp()
  path=f'/eniq/sw/conf/engineLogging.properties'
  print('Connection established successfully')
  content=[]
  with ssh_transfer.open(path,'r') as f:
   f.prefetch()
   con=f.readlines() 
  for l in con:
    if 'FINEST' in l:
        b=re.sub('FINEST','INFO',l)
        content.append(b)
        print(b)
    else:
        content.append(l)
  with ssh_transfer.open(path,'w') as w:
   for i,l in enumerate(content):
      for intf in topotp:
         if intf in l:
            if 'INFO' in l:
               a=re.sub('INFO','FINEST',l)
               print(a)
               w.write(a)
               break
            else:
               continue
      else:
         w.write(l)
  return topotp

def activate_interface():
  server_number='4119'
  ssh_client = paramiko.SSHClient()
  server = f'atvts{server_number}.athtem.eei.ericsson.se'
  port = 2251
  user = 'dcuser'
  password = 'dcuser'
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
      ssh_client.connect(server,port,user,password)
      print('Connection established successfully')
      
      stdin,stdout,stderr =ssh_client.exec_command('cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t DIM_E_CN')
      output = stdout.read()
      print(output)
  except Exception as e:
    print("Error is= ",e)
  finally:
      ssh_client.close()
      print('All Connections are Closed')

def filter_topotable_name(str):
  strarr=str.split('\r\n')
  topotp=''
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      topotp=strarr[i].strip()
  return topotp

def filter_node_name(str):
  strarr=str.split('\r\n')
  return strarr[0].strip()

def filter_name(str):
  strarr=str.split('\r\n')
  #print(strarr)
  return strarr[0].strip()

def filter_latest_name(str):
  strarr=str.split('\r\n')
  s1=''
  for i in strarr:
    if i=='':
      break
    s1=i.strip()
  return s1

def filter_date_from_epfg(str):
  strarr=str.split("\r\n")
  for l in strarr:
    if l.startswith("newendtime is"):
      return l.split("=")[1]
  return " "

def checking_log_of_dim_intf(package,host,portno,userid,pwd):
 print(package)
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 print(path)
 try:
     engine=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.tpi.log') and package in f.filename:
             a=f.filename
             break
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('_tp_installer.log') and package in f.filename:
             b=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     # print(f"<{keyword}> found in line {i+1} of engine log file")
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     with sftp_obj.open(b) as f1:
         f1.prefetch()
         buffer1 = f1.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     tp_installer=1
     if tp_installer==0:
         print(f'No issues found in file {b} under path-> {path}')
     if tp_installer==1:
         print(f'Some issues found in file {b} under path-> {path}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '

def checking_tp_activation(package,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 path1=f'/eniq/log/sw_log/engine/{package}-eniq_oss_1'
 print(path)
 try:
     engine=0
     tp_installer=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_activate_'+package+'_eniq_oss_1.log'):
             a=f.filename
             break 
     print(b)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     sftp_obj.chdir(path1)
     engine_pkg_log=0
     print('reached -> ' +path1)
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_tp_installer.log'):
             c=f.filename
             break
     with sftp_obj.open(c) as f2:
         f2.prefetch()
         buffer2 = f2.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine_pkg_log=1
     if engine_pkg_log==0:
         print(f'No issues found in file {c} under path-> {path2}')
     if engine_pkg_log==1:
         print(f'Some issues found in file {c} under path-> {path2}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return " "

def checking_tp_installer_log(pkg,package,host,portno,userid,pwd):
 print(package)
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 path1=f'/eniq/log/sw_log/engine/{pkg}'
 print(path)
 try:
     engine=0
     tp_installer=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith(package+'.log'):
             a=f.filename
             break
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_tp_installer.log'):
             b=f.filename
             break
     
     print(b)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     with sftp_obj.open(b) as f1:
         f1.prefetch()
         buffer1 = f1.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     tp_installer=1
     if tp_installer==0:
         print(f'No issues found in file {b} under path-> {path1}')
     if tp_installer==1:
         print(f'Some issues found in file {b} under path-> {path1}')
         return 'fail'
     sftp_obj.chdir(path1)
     engine_pkg_log=0
     print('reached -> ' +path1)
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_tp_installer.log'):
             c=f.filename
             break
     with sftp_obj.open(c) as f2:
         f2.prefetch()
         buffer2 = f2.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine_pkg_log=1
     if engine_pkg_log==0:
         print(f'No issues found in file {c} under path-> {path2}')
     if engine_pkg_log==1:
         print(f'Some issues found in file {c} under path-> {path2}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return " "



def filter_date(strtmp):
  print(strtmp)
  strarr=strtmp.split('\r\n')
  str1=strarr[0].strip()
  print(str1)
  mntharray=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  for i in range (0,11):
      if mntharray[i] in str1 and i<9:
         z=i+1
         break;
  datetimearr=str1.split(" ")
  temparr=[i for i in datetimearr if i.strip()]
  print(temparr)
  y = datetime(int(temparr[2]),z, int(temparr[1]),int(temparr[3].split(":")[0]),int(temparr[3].split(":")[1]),int(temparr[3].split(":")[2].split(".")[0]))
  return str(y)

def getmodifiedtime(package,tablename,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 linetmp=''
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/engine/{package}'
 print(path)
 try:
     keywords=[package+'.Topology.TopologyLoader_'+tablename+'.1.UnPartitionedLoader : Found 1 files']
     print(keywords)
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.log'):
             a=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 if re.search(keyword, line, re.IGNORECASE): 
                     print(f'{keyword} found in->',line)
                     linetmp=line
                     break
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 try:
  output=str(linetmp.split(" ")[1].split(":")[0]+":"+linetmp.split(" ")[1].split(":")[1])
  return output
 except Exception as e:
   print("Error is -> ",e)
 return " "

def update_automation_file(scriptname,date,tpname,modeltname,server,port,user,password):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  if scriptname=='KeyCounter_Loading_Check.zip':
    path=f'/eniq/home/dcuser/Loading/input.properties'
    print('Connection established successfully')
    datem = datetime.strptime(date, "%d-%m-%Y-%H:%M")
    print(datem.day)        # 25
    print(datem.month)      # 5
    print(datem.year)       # 2021
    print(datem.hour)
    print(datem.minute)
    with ssh_file.open(path,'r') as f:
       con=f.readlines()
    print(con)
    with ssh_file.open(path,'w') as f:
     for l in con:
       if 'Date_id' in l:
            if datem.day<=9:
               b=re.sub('07','0'+str(datem.day),l)
            else:
               b=re.sub('07',str(datem.day),l)
            f.write(b)
            print(b)
       elif 'Month_id' in l:
            if datem.month<=9:
               b=re.sub('02','0'+str(datem.month),l)
            else:
               b=re.sub('02',str(datem.month),l)
            f.write(b)
            print(b)
       elif 'Hour_id' in l:
            if datem.hour<=9:
               b=re.sub('07','0'+str(datem.hour-1),l)
            else:
               b=re.sub('07',str(datem.hour-1),l)
            f.write(b)
            print(b)
       elif 'Min_id' in l:
            if datem.minute<=9:
               b=re.sub('09','0'+str(datem.minute),l)
            else:
               b=re.sub('09',str(datem.minute),l)
            f.write(b)
            print(b)
       elif 'Model-T_Name' in l:
            b=re.sub('DC_E_SCEF_3_R1A.xlsx',str(modeltname),l)
            f.write(b)
            print(b)
       else:
           f.write(l)
  elif scriptname=='DAY_Aggregation_Validator.zip':
    path=f'/eniq/home/dcuser/dayaggregation/automation.properties'
    print('Connection established successfully')
    datem = datetime.strptime(date, "%d-%m-%Y-%H:%M")
    print(datem.day)        # 25
    print(datem.month)      # 5
    print(datem.year)       # 2021
    with ssh_file.open(path,'r') as f:
       con=f.readlines()
    print(con)
    with ssh_file.open(path,'w') as f:
     for l in con:
       if 'Day_id' in l:
           b=re.sub('07',str(datem.day),l)
           f.write(b)
           print(b)
       elif 'Month_id' in l:
            b=re.sub('02',str(datem.month),l)
            f.write(b)
            print(b)
       elif 'Year_id' in l:
            b=re.sub('2020',str(datem.year),l)
            f.write(b)
            print(b)
       elif 'Model-T_Name' in l:
            b=re.sub('DC_E_SCEF_3_R1A.xlsx',str(modeltname),l)
            f.write(b)
            print(b)
       elif 'Techpack_Name' in l:
            b=re.sub('DC_E_SCEF_%_RAW',str(tpname),l)
            f.write(b)
            print(b)
       else:
           f.write(l)


def dependent_pkg_and_intf(output: str):
    b = output.split('\r\n')
    dep_interfaces=[]
    for w in b:
        a = w.strip()
        if a.startswith('INTF'):
            dep_interfaces.append(a)
    return dep_interfaces

def return_true_false(output: str):
  return output.split('\r\n')[len(output.split('\r\n'))-2]

def collectionid(output:str):
  try:
    z=' ----------------------------------------- '
    a=output.split('\r\n')
    print(a)
    return a[a.index(z)+1].strip()
  except Exception as e:
   print("Error is -> ",e)
  
  return " "

def getIndir(output:str):
  try:
    a=output.splitlines()
    for i in a:
      if 'inDir' in i:
        b=i.split("/")
        c=list(filter(None, b))
        return c[-1]
  except Exception as e:
    print("error is -> ",e)
  
  return " "

def editing_datetime_in_epfg_for_nr(output:str):
    x=output.split(" ")
    date=x[1]+" "+x[2]+" "+x[5]+" "+x[3]
    print(date)
    cur_time=datetime.strptime(date,"%b %d %Y %H:%M:%S")
    print(cur_time)
    final_time = cur_time + timedelta(minutes=2)
    print(final_time)
    final_time=datetime.strftime(final_time,"%d-%m-%Y-%H:%M")      
    print(final_time)
    return final_time


def filter_err_count(str):
  strarr=str.split('\r\n')
  try:
      return strarr[1].strip()
  except Exception as e:
    print("Exception is -> "+ e)

def makestr(temp):
  print(temp.split('\n'))
  s=''
  if(len(temp.split('\n'))>9):
    for i in range(9,len(temp.split('\n'))):
      #arr.append(temp.split('\n')[i])
      s=s+temp.split('\n')[i]+'\n'
    return s
  else:
    return 'true'
  return ""


def removestr(temp):
    print(temp)
    arr=[*temp]
    s=''
    for i in range(0,len(arr)-1):
      s+=arr[i]
    return s


def filterlength(s):
    print(s.split('\r\n'))
    return s.split('\r\n')[-2].strip()

def edit_epfg_for_multiple_oss(server,port,user,password):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  f=f'/eniq/home/dcuser/epfg/config/epfg.properties'
  with ssh_file.open(f,'r') as r:
    txt=r.readlines()
  with ssh_file.open(f,'w') as w:
    for l in txt:
        if l.startswith('ENIQ_VOLUME_MT_POINT='):
            x=re.sub('/eniq/data/pmdata/eniq_oss_1/','/eniq/data/pmdata/eniq_oss_1/;/eniq/data/pmdata/eniq_oss_2/',l)
            w.write(x)
            print(x)
        else:
            w.write(l)


def list_of_nodename(output):
    temp=output.split('\r\n')
    arr=[]
    for i in range(0,len(temp)):
      if temp[i].strip().startswith('('):
        break
      else:
        arr.append(temp[i].strip())
    arr.pop()
    print(arr)
    return arr

  
def test(output:str):
  return output.split('\r\n')[2].strip()

def processed_directory(output:str):
  arr=output.split('\r\n')
  for i in arr:
    if i.startswith("ProcessedFiles.fileNameFormat"):
      return i.split("=")[1]
  print(arr)

def system_status(s:str):
  dictr={}
  arr=s.split('\n')
  for i in arr:
      i=i.split()
      dictr.update({i[0]:i[1]})
  statusDictr=['eniq-connectd.service','eniq-dwhdb.service', 'eniq-engine.service', 'eniq-esm.service','eniq-licmgr.service', 'eniq-lwphelper.service', 'eniq-repdb.service', 'eniq-rmiregistry.service','eniq-scheduler.service', 'eniq-webserver.service']
  otherStatus=[]
  #print(dictr['eniq-connectd.service'])
  for key in statusDictr:
      if dictr[key]=='inactive':
          serviceName=key.split(".")[0]
          otherStatus.append(serviceName)
  return otherStatus

def getting_engine_profile(s:str):
  arr=s.split('\n')
  print(arr)
  for i in arr:
      if 'Current Profile:' in i:
        return i.strip()
  return ""

def give_build_number(s:str):
  if s.startswith('(('):
    return s.split("((")[1].split("))")[0]
  return s.split(":")[1].split("((")[1].split("))")[0]

def loading_topo_check(package,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/engine/{package}'
 print(path)
 try:
     engine=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.log'):
             a=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     # print(f"<{keyword}> found in line {i+1} of engine log file")
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '

def services_list(output1:str):
  output='''SERVICE               STATE       SUBSTATE    ENABLED     START TIME
  eniq-scheduler        inactive      running     enabled     Wed 2022-11-09 06:07:22 GMT
  eniq-engine           active      running     enabled     Fri 2022-11-18 10:58:47 GMT
  eniq-lwphelper        active      running     enabled     Wed 2022-11-09 06:08:07 GMT
  eniq-webserver        active      running     enabled     Wed 2022-11-09 07:22:32 GMT
  eniq-dwhdb            active      running     enabled     Wed 2022-11-09 06:08:59 GMT
  eniq-repdb            active      running     enabled     Wed 2022-11-09 06:07:19 GMT
  eniq-connectd         active      running     enabled     Wed 2022-11-09 06:07:11 GMT
  eniq-licmgr           active      running     enabled     Wed 2022-11-09 06:35:14 GMT
  eniq-rmiregistry      active      running     enabled     Wed 2022-11-09 06:07:12 GMT
  eniq-esm              active      running     enabled     Wed 2022-11-09 06:07:11 GMT
  eniqs[eniq_stats] {root} #:'''
  out_arr=[]
  arr=output1.split('\n')
  dictr={}
  c=0
  for i in arr:
    if(c!=0 and c<len(arr)-1):
      i=" ".join(i.split())
      i=i.split()
      dictr.update({i[0]:i[1]})
      c+=1
    elif c==0:
      c=1
  for key in dictr:
    if dictr[key]=='inactive':
      out_arr.append(key)
  return out_arr

def verify_area_file_data_loading(pkg,output):
  s=output
  ar=s.split('\n')
  c=0
  ar1=[]
  for i in ar:
    #print(i.strip())
    if(i.strip()==''):
      break
    ar1.append(i.strip())
  print(ar1)
  cmp_ar=[]
  if pkg=='DIM_E_UTRAN':
    s1='''AREA;AREA_GROUP;OSS_ID;CELL_ID;CELL_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;100;cell100;RNC
Lahti;Cell set;eniq_oss_1;10;cell10;RNC
Athlone;Cell Set;eniq_oss_1;199;Cell199;RNC
Athlone;Cell Set;eniq_oss_1;99;Cell99;RNC'''
    file_ar=s1.split('\n')
    file_ar.pop(0)
    for i in file_ar:
        for x in i.split(';'):
          cmp_ar.append(x)
    print(cmp_ar)
  if pkg=='DIM_E_GRAN':
    s1='''AREA,AREA_GROUP,OSS_ID,CELL_ID,CELL_NAME,NW_TYPE
Athlone,Cell Set,eniq_oss_1,AR12C00,AR12C00,AXE
Athlone,Cell Set,eniq_oss_1,AR12C01,AR12C01,AXE
Athlone,Cell Set,eniq_oss_1,AR12C02,AR12C02,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C03,AR12C03,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C04,AR12C04,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C05,AR12C05,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C06,AR12C06,AXE'''
    file_ar=s1.split('\n')
    file_ar.pop(0)
    for i in file_ar:
        for x in i.split(','):
          cmp_ar.append(x)
    print(cmp_ar)
  if(ar1==cmp_ar):
    return 'true'
  return 'false'

def verify_area_file_for_lte_nr(pkg,out1,out2):
  s=out1
  st=out2
  ar=s.split('\n')
  arr=st.split('\n')
  c=0
  ar1=[]
  for i in ar:
      #print(i.strip())
      if(i==''):
          break
      ar1.append(i.strip())
  ar2=st.split('\n')
  c=0
  ar2=[]
  for i in arr:
      #print(i.strip())
      if(i==''):
          break
      ar2.append(i.strip())  
  print(ar1)
  print(ar2)

  s1='''AREA;AREA_GROUP;OSS_ID;CELL_ID;CELL_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;100;cell100;ERBS
Lahti;Cell set;eniq_oss_1;10;cell10;ERBS
Athlone;Cell Set;eniq_oss_1;199;Cell199;ERBS
Athlone;Cell Set;eniq_oss_1;99;Cell99;ERBS'''
  s2='''AREA;AREA_GROUP;OSS_ID;NRCELLCU_ID;NRCELLCU_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;200;Cell200;NR
Lahti;Cell set;eniq_oss_1;20;Cell20;NR
Athlone;Cell Set;eniq_oss_1;15;cell15;NR
Athlone;Cell Set;eniq_oss_1;30;cell30;NR'''
  file_ar=s1.split('\n')
  file_ar1=s2.split('\n')
  cmp_ar=[]
  file_ar.pop(0)
  for i in file_ar:
      for x in i.split(';'):
          cmp_ar.append(x)
          file_ar=s1.split('\n')
  cmp_ar1=[]
  file_ar1.pop(0)
  for i in file_ar1:
      for x in i.split(';'):
          cmp_ar1.append(x)
  print(cmp_ar)
  print(cmp_ar1)
  if(cmp_ar==ar1 and cmp_ar1==ar2):
    return 'true'
  return 'false'

def BT_FT_validation(out):
  ar=out.split('You have chosen 2,4')
  li=ar[1].split('\n')
  #print(li)
  r1=False
  r2=False
  for i in li:
      if 'Topology_Loading Check:PASS-' in i:
          if 'PASS- 0' not in i and 'FAIL- 0' in i:
              r1=True
      if 'ManMods_Check:PASS-' in i:
          if 'PASS- 0' not in i and 'FAIL- 0' in i:
              r2=True
  #print(r1,r2)
  return r1,r2

def get_table_list(tables):
  tablelist=tables.split('\n')
  for i in range(0,len(tablelist)):
    tablelist[i]=tablelist[i].strip()
    
  tablelist.pop(-1)
  tablelist.pop(-1)
  tablelist.pop(-1)
  return tablelist

def verify_datetime_utctime(datetimedb,offsetdb,utcdatedb):
  datelist=datetimedb.split('\n')
  for i in range(0,len(datelist)):
    datelist[i]=datelist[i].strip()
  datelist.pop(-1)
  datelist.pop(-1)
  datelist.pop(-1)
  offsetlist=offsetdb.split('\n')
  for i in range(0,len(offsetlist)):
    offsetlist[i]=offsetlist[i].strip()
  offsetlist.pop(-1)
  offsetlist.pop(-1)
  offsetlist.pop(-1)
  utcdatelistdb=utcdatedb.split('\n')
  for i in range(0,len(utcdatelistdb)):
    utcdatelistdb[i]=utcdatelistdb[i].strip()
  utcdatelistdb.pop(-1)
  utcdatelistdb.pop(-1)
  utcdatelistdb.pop(-1)
  for i in range(0,len(utcdatelistdb)):
    datetime_object = datetime.strptime(utcdatelistdb[i], '%b %d %Y %H:%M:%S.000000AM')
    if offsetlist[i]=='+0200':
        utcdatelistdb[i]=datetime.strftime(datetime_object+timedelta(hours=2),'%b %d %Y %H:%M:%S.000000AM')
    if offsetlist[i]=='-0200':
        utcdatelistdb[i]=datetime.strftime(datetime_object-timedelta(hours=2),'%b %d %Y %H:%M:%S.000000AM')
  return utcdatelistdb==datelist
  
def validating_ossId(out):
  ossIdList=out.split('\n')
  for i in range(0,len(ossIdList)):
    ossIdList[i]=ossIdList[i].strip()
  ossIdList.pop(-1)
  ossIdList.pop(-1)
  ossIdList.pop(-1)
  print(ossIdList,len(ossIdList))
  for i in ossIdList:
    if i == 'eniq_oss_1' or i =='eniq_oss_2':
      continue
    else:
      return False
  return True 

def afg_specific(server,port,user,password,datevar):
 ssh_client = paramiko.SSHClient()
 filenamelist=[]
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/archive/eniq_oss_1/AFG_ECIM/processed'
 result=True
 print(path)
 try:
     
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     c=0
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if not f'INTF_DC_E_AFG_{datevar}' in f.filename:
          return False
         if f'INTF_DC_E_AFG_{datevar}' in f.filename:
          filenamelist.append(f.filename)
          c=c+1
     if c!=8:
      return False
     
     for filename in filenamelist:
        filepath=f'/eniq/archive/eniq_oss_1/AFG_ECIM/processed/{filename}'
        with sftp_obj.open(filepath,'r') as f:
            f.prefetch()
            li=f.readlines()
            #li=s1.split()
            #print(li)
            timevar1=filename.split('.')[1]
            timevar2=str((int)(timevar1) +15)
            if timevar1=='1045':
              timevar2='1100'
            if timevar1=='1145':
              timevar2='1200'
            #print(timevar1,timevar2)
            for i in li:
                i=i.strip()
                templi=i.split('_')
                if templi[0] != f'A{datevar}.{timevar1}+0200-{timevar2}+0200':
                    result=False
                    #print(f'A{datevar}.{timevar1}+0200-{timevar2}+0200' == 'A20230328.1000+0200-1015+0200')
                    print(i,templi[0])
                    break
                if not (templi[1].startswith('SubNetwork=SubNetwork,NetworkElement=vAFG')):
                    result=False
                    print(i,templi[1])
                    break
                if templi[2]!=f'{datevar}-{timevar1}':
                    result=False
                    print(i,templi[2])
                    break
                if templi[3]!='statsfile.tar.gz':
                    result=False
                    print(i,templi[3])
                    break
                if (not templi[4].startswith(f'A{datevar}.{timevar1}+0200-{timevar2}+0200-') or ( templi[4].endswith('-'))):
                    result=False
                    print(i,templi[4])
                    break
                if (not templi[5].endswith('.xml')) or (not 'vAFG' in templi[5]) or (templi[5].startswith('.')):
                    result=False
                    print(i,templi[5])
                    break
    #  with sftp_obj.open(a) as f:
    #      f.prefetch()
    #      buffer = f.readlines()
    #      for keyword in keywords:
    #          for i, line in enumerate(buffer):
    #              if re.search(keyword, line, re.IGNORECASE):
    #                  print(f'{keyword} found in->',line)
    #                  engine=1
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '



