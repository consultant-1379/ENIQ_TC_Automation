import opensession_runcommand
import os
import paramiko
def check_emc_package_exist(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /etc/resolv.conf")
    emcpackage = emcpackage.split()
    if(emcpackage[-1]!="nameserver"):
        if(":" in emcpackage[-1] or "." in emcpackage[-1]):
            return("True")
        else:
            return("False")
    else:
        return("False")

