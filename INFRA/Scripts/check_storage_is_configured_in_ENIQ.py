import opensession_runcommand
import os
cmd1="ls /ericsson/storage/san/etc/ | grep 'storage.conf'"
def Verify_if_ENIQ_is_connected_with_storage(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if 'storage.conf' in output1:
        return "True"
    else:
        return "False"