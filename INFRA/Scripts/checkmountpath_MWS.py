import paramiko
import sys
sys.path.append('../Resources/Variables')
import variables_for_robot

def check_mount_path(mwshost, mwsuser, mwspwd):
    #logging into server
    client = paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(mwshost, username=mwsuser, password=mwspwd)
    
    #creating a list of cached medias on server
    stdin, stdout, stderr = client.exec_command("ls " + variables_for_robot.mountpath)
    medialist = stdout.read().decode().split()
    is_patch_mounted = "False"
    #iterate through cached media list and check for installed patch version
    for i in range(len(medialist)):
        #print("ls " + variables_for_robot.mountpath + medialist[i].strip() + "/RHEL/|grep -E " + "RHEL[0-9]+")
        stdin, stdout, stderr = client.exec_command("ls " + variables_for_robot.mountpath + medialist[i].strip() + "/RHEL/|grep -E " + "RHEL[0-9]+")
        rhel_patch_version_cached = stdout.read().decode()
        #print(rhel_patch_version_cached)
        if variables_for_robot.patch_version_installed_mws in rhel_patch_version_cached:
            is_patch_mounted = "True"
            break
    return(is_patch_mounted)


