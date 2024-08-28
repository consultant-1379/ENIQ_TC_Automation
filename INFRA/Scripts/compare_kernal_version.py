import opensession_runcommand
import sys  
sys.path.insert(0, '/root/robotenvironment/ENIQ_INFRA_PatchUpgrade_LegacyTCs_shantanu/variables')
import variable_patch_TC
import os
import paramiko
def compare_kernal_version(hostname,user,pwd):
    path_media_kernal_version =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /JUMP/INSTALL_PATCH_MEDIA")
    outputlist = path_media_kernal_version.split()
    count=0
    for i in range(len(outputlist)):
        path_media_kernal =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /JUMP/INSTALL_PATCH_MEDIA/"+outputlist[i]+"/RHEL")

        outputlist2 = path_media_kernal.split()
        for k in range(len(outputlist2)):
            if outputlist2[k]==variable_patch_TC.patchver:
               count = 1
               break
        if count==1:
           return "True"
           break
    if count ==0:
        return "False"
        
	 



