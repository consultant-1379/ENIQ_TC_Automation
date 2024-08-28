import paramiko
import re
from datetime import datetime
def transfer_to_server(file):
  print(file)  
  server_number='4043'
  ssh_client = paramiko.SSHClient()
  server = f'atvts{server_number}.athtem.eei.ericsson.se'
  port = 2251
  user = 'dcuser'
  password = 'Dcuser12#'
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
      ssh_client.connect(server,port,user,password)
      print('Connection established successfully')
      ssh_transfer=ssh_client.open_sftp()
      path=r'/eniq/sw/installer/'
      #ssh_transfer.mkdir(path)
      print(f'Directory- {path} created')
      ssh_transfer.put(f'H://Downloads//{file}', f'{path}//{file}')
      print(f'File {file} transferred to {path} Successfully' )
      #ssh_client.exec_command(f'mv {file}  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'unzip  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'cd  BT-FT_Script/ ')
      #ssh_client.exec_command(f'pwd')

  except Exception as e:
    print("Error is= ",e)
  finally:
      ssh_transfer.close()
      ssh_client.close()
      print('All Connections are Closed')

def show_status_eniqs(str,services):
  statusarr=str.split('\n')
  servicearr=services.split(' ')
  for i in range(0,len(servicearr)):
    if 'active' in statusarr[i]:
      statusarr[i]='active'
    else:
      statusarr[i]='not active'
    print(servicearr[i] + '->' + statusarr[i])  

def checking_errors_in_log_file(package):
 print(package)
 server_number='4043'
 ssh_client = paramiko.SSHClient()
 server = f'atvts{server_number}.athtem.eei.ericsson.se'
 port = 2251
 user = 'dcuser'
 password = 'Dcuser12#'
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/engine/{package}'
 print(path)
 path2=r'/eniq/log/sw_log/tp_installer'
 try:
     engine=0
     tp_inst=0
     tpilog=0
     nodefile=0
     found_pkg=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
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
     b=[]
     lim=10
     gotnodefile=0
     gottpifile=0
     sftp_obj.chdir(path2)
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('tp_installer.log'):
             b.append(f.filename)
             lim-=1
             if lim==0:
                 break
         if package in f.filename and f.filename.endswith('.tpi.log') and gottpifile==0:
             tpilogfile=f.filename
             gottpifile=1
         if f.filename.startswith('node_type_granularity') and gotnodefile==0:
             nodegranfile=f.filename
             gotnodefile=1
     print(b)
     print(tpilogfile)
     print(nodegranfile)
     if b:
         for i in b:
             with sftp_obj.open(i) as f:
                 f.prefetch()
                 buffer = f.readlines()
                 for line in buffer:
                     if re.search(f'^{package}$', line, re.IGNORECASE):
                         found_pkg=1
                         tp_inst_file=i
                         break
                 else:
                     continue
                 break
         if found_pkg==1:
             with sftp_obj.open(tp_inst_file) as f:
                 f.prefetch()
                 buffer = f.readlines()
                 for keyword in keywords:
                     for i, line in enumerate(buffer):
                         if re.search(keyword, line, re.IGNORECASE):
                             print(f"<{keyword}> found in line {i+1} of tp_installer log file")
                             tp_inst=1
        
         else:
             print(f"{package} not found in any tp_installer log files")
     if tpilogfile:
         with sftp_obj.open(tpilogfile) as f:
             f.prefetch()
             buffer = f.readlines()
             for keyword in keywords:
                 for i, line in enumerate(buffer):
                     if re.search(keyword, line, re.IGNORECASE):
                         print(f"<{keyword}> found in line {i+1} of .tpi.log file")
                         tpilog=1
     if nodegranfile:
         with sftp_obj.open(nodegranfile) as f:
             f.prefetch()
             buffer = f.readlines()
             for keyword in keywords:
                 for i, line in enumerate(buffer):
                     if re.search(keyword, line, re.IGNORECASE):
                         print(f"<{keyword}> found in line {i+1} of node_granularity file")
                         nodefile=1
     else:
         print("No tp_installer log file found")
 
             # for i, line in enumerate(buffer):
             #     if keyword in line:
             #         print(f'"{keyword}" found in line {i+1} ')
             #         s=1
         # for line in buffer:
         #     for k in keywords:
         #         if k in line:
         #             s+=1
         #             print(f'Keyword {k} found in line {buffer.index(line)+1}')
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
     if tp_inst==0:
         print(f'No issues found in file {tp_inst_file} under path-> {path2}')
     if tp_inst==1:
         print(f'Some issue found in file {tp_inst_file} under path-> {path2}')
     if tpilog==0:
         print(f'No issues found in file {tpilogfile} under path-> {path2}')
     if tpilog==1:
         print(f'Some issue found in file {tpilogfile} under path-> {path2}')
     if nodefile==0:
         print(f'No issues found in file {nodegranfile} under path-> {path2}')
     if nodefile==1:
         print(f'Some issue found in file {nodegranfile} under path-> {path2}')
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')


