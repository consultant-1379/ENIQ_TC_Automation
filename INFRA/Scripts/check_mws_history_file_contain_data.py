import opensession_runcommand
import os
import paramiko
def check_mws_history_file_contain_data(hostname,user,pwd):
    mwshistoryfile =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /ericsson/config/mws_history")
    if len(mwshistoryfile)== 0:
       return("False")
    else:
       return("True")

