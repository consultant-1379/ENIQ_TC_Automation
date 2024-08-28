import opensession_runcommand
import os
import sys
cmd1="grep -o -c 'BLK_STORAGE_IP_SP' /eniq/installation/config/block_storage.ini"
def Verify_Check(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    print(output1)
    if ("" ==output1):
        return 'False'
    else:
        if (int(output1)>0):
            return 'True'
        else:
            return 'False'

