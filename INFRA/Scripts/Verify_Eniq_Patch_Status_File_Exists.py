import opensession_runcommand
import os
import paramiko
word="No packages to update"
store=''
def check_emc_package_exist(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls -lrt /var/ericsson/log/patch/ | grep pre_upgrade_patchrhel.bsh_ | tail -1")
    emcpackage = emcpackage.split()

    emcpackage1 =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /var/ericsson/log/patch/"+emcpackage[len(emcpackage)-1]+ "|grep 'No packages to update' ")
    #print(emcpackage)
    #print(emcpackage1)
    #print("shantanu")
    if word in emcpackage1:
        store="TRUE"
    else:
        store="FALSE"
    return(store)
    END
