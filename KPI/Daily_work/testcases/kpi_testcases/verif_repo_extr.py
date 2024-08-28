from stat import S_ISDIR, S_ISREG
import paramiko

package='DC_E_ERBS'
server_number='4107'
ssh_client = paramiko.SSHClient()
server = f'atvts{server_number}.athtem.eei.ericsson.se'
port = 2251
user = 'dcuser'
password = 'Dcuser12#'

ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
    ssh_client.connect(server,port,user,password)
    sftp_obj=ssh_client.open_sftp()
    for entry in sftp_obj.listdir_attr(r'/eniq/sw/installer/BO/BO_E_ERBS_R47A_b262'):
            mode = entry.st_mode
            if S_ISDIR(mode):
                print(entry.filename + " is folder")
            elif S_ISREG(mode):
                print(entry.filename + " is file")
except paramiko.ssh_exception.AuthenticationException:
    print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
except Exception as e:
    print("Error is= ",e)