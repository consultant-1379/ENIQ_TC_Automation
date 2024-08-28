import opensession_runcommand
import os
import paramiko

def get_patch_version(hostname,user,pwd):
    patch_media_version =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=" cat /ericsson/config/mws_history | grep MWS_PATCH_UPDATE_MEDIA_STATUS | tail -1")
    patch_media_version = patch_media_version.split('=')
    patch_media_version[-1] = patch_media_version[-1].replace("\n","")
    return(patch_media_version[-1])