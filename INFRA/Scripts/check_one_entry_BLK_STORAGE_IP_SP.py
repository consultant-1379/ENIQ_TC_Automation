import opensession_runcommand
import os
import sys
#cmd1="cat /eniq/installation/config/block_storage.ini  | grep 'BLK_STORAGE_IP_SP'"
cmd1="grep -o -c 'BLK_STORAGE_IP_SP' /eniq/installation/config/block_storage.ini"
def Verify_if_ENIQ_is_connected(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if int(output1)==1:
        return "Unity"
    elif int(output1)==2:
        return "VNX"
    else:
        return "invalid"
