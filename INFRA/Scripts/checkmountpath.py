import paramiko

def check_mount_path(mwshost, mwsuser, mwspwd, patchtobeinstalled, pathtocheck):
    client = paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(mwshost, username=mwsuser, password=mwspwd)
    stdin, stdout, stderr = client.exec_command("cd /JUMP/INSTALL_PATCH_MEDIA/5/RHEL; ls -l|grep RHEL7.9-3.0.13")
    lines = stdout.read().decode()
    print(lines)



    
