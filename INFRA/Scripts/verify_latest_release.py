import opensession_runcommand
import os
import paramiko
def latest_release_value(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls -lrt /var/ericsson/log/OM_UPGRADE/ | grep 'upgrade_om_packages_' | tail -1")
    emcpackage = emcpackage.split()
    emcpackage1 =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /var/ericsson/log/OM_UPGRADE/"+emcpackage[len(emcpackage)-1]+" | grep 'Location: ' | head -1")
    emcpackage1 = emcpackage1.split('/')
    release_value=emcpackage1[len(emcpackage1)-6]
    return(release_value)
