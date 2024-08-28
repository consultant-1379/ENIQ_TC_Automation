import opensession_runcommand
import os
import paramiko

def get_kernal_version(hostname,user,pwd):
    path_media_kernal_version =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /JUMP/UPGRADE_PATCH_MEDIA")
    outputlist = max(path_media_kernal_version.split())
    return outputlist