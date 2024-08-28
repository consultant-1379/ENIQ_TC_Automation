import opensession_runcommand
import os
import paramiko
def check_mws_history_file_contain_data(hostname,user,pwd):
    mwshistoryfile =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /ericsson/config/mws_history| grep MWS_PATCH_UPDATE_MEDIA_STATUS")
    count = 0
    file_exists= mwshistoryfile.split()
    mi =[]
    for i in range(2,len(file_exists),4):
        mi.append(file_exists[i])
    for k in range(len(mi)-1):
        for m in range(k+1,len(mi)):
            if mi[k]==mi[m]:
                count = count+1
    if count ==0:
        return "True"
    else:
        return "False"

