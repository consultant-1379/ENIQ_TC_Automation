import paramiko
import re
'''
Connect to required remote server using Paramiko library.
Move to eniq/log/sw_log/engine/<Installed-package-name>
Get the latest .log file's absolute path out of the list of files.
Open that file and store it's content into buffer.
Loop through that file line by line and search for keywords stored in a list.
If any keywords found in file, print the line number and word found.
Close both SFTP and SSH connection with try catch block.
'''
 
package='DC_E_ERBS'
server_number='4107'
ssh_client = paramiko.SSHClient()
server = f'atvts{server_number}.athtem.eei.ericsson.se'
port = 2251
user = 'dcuser'
password = 'Dcuser12#'
ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
path=f'/eniq/log/sw_log/engine/{package}'
path2=r'/eniq/log/sw_log/tp_installer'
try:
    engine=0
    tp_inst=0
    found_pkg=0
    keywords=['SEVERE','EXCEPTION','ERROR','FAILED','SKIP','WARNING']
    ssh_client.connect(server,port,user,password)
    sftp_obj=ssh_client.open_sftp()
    sftp_obj.chdir(path)
    for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
        if f.filename.endswith('.log'):
            a=f.filename
            break
    with sftp_obj.open(a) as f:
        f.prefetch()
        buffer = f.readlines()
        for keyword in keywords:
            for i, line in enumerate(buffer):
                if re.search(keyword, line, re.IGNORECASE):
                    
                    print(f'{keyword} found in->',line.split(' : ')[1])
                    # print(f"<{keyword}> found in line {i+1} of engine log file")
                    engine=1
    b=[]
    lim=10
    sftp_obj.chdir(path2)
    for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
        if f.filename.endswith('tp_installer.log'):
            b.append(f.filename)
            lim-=1
            if lim==0:
                break
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
except paramiko.ssh_exception.AuthenticationException:
    print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
except Exception as e:
    print("Error is= ",e)   
else:
    sftp_obj.close()
    ssh_client.close()
    print('Connection Closed')

