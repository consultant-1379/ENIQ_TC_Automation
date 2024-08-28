import paramiko
import re
from datetime import datetime
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

def filter_interface_name(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
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

def filter_intf_name(tpname,str,server:str,user:str,password:str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INTF') or strarr[i].startswith(' DIM') ):
      topotp.append(strarr[i].strip())
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  topotp.append(tpname[0].strip())
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

def checking_log_of_dim_intf(package,host,portno,userid,pwd):
 print(package)
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
     print(server,port,user,password)
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
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')

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
 return str(linetmp.split(" ")[1].split(":")[0]+":"+linetmp.split(" ")[1].split(":")[1])
