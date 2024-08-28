import paramiko
import sys, getopt, string


#logging into server
client = paramiko.client.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#client.connect(mwshost, username=user, password=pwd)
client.connect('10.45.198.174', username='root', password='Infra$123')

#creating a list of cached medias on server
stdin, stdout, stderr = client.exec_command("ls /JUMP/UPGRADE_PATCH_MEDIA/")
patchlist = stdout.read().decode().split()
is_patch_mounted = "False"
    #iterate through cached media list and check for installed patch version
for i in range(len(patchlist)):
        
	stdin, stdout, stderr = client.exec_command("ls /JUMP/UPGRADE_PATCH_MEDIA/" + patchlist[i] + "/RHEL/|grep " + '3.0.16')
	output = stdout.read().decode()
        
	if '3.0.16' in output:
		is_patch_mounted = "True"
		print ("Patch Folder: " + patchlist[i])
		break
if is_patch_mounted == False:
	print("Patch is not mounted in MWS for upgrade.")
