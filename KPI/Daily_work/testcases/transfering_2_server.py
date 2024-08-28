import paramiko
from datetime import datetime
file='afg_testing.tpi'
server_number='4122'
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
    path=r'/eniq/sw/installer/BO'+ datetime.now().strftime('%d%b-%H%M%S')
    ssh_transfer.mkdir(path)
    print(f'Directory- {path} created')
    ssh_transfer.put(f'H://Downloads//{file}', f'{path}//{file}')
    print(f'File {file} transferred to {path} Successfully' )

except Exception as e:
    print("Error is= ",e)
finally:
    ssh_transfer.close()
    ssh_client.close()
    print('All Connections are Closed')