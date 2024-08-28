import opensession_runcommand
import os
import paramiko
hostname='ieatrcx4086'
user='root'
pwd='Patch@123'
def check_emc_package_exist(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /JUMP/OM_LINUX_MEDIA/OM_LINUX_022_4/22.4.8.EU2/om_linux/EMC/packages.inc")
    #print(emcpackage)
    emcpackage = emcpackage.split()
    count=0
    #print(emcpackage)
    for i in range (len(emcpackage)):
        package=emcpackage[i].split("-")
        package=package[0]
        output1 =opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="rpm -qa|grep "+package)
        print(output1)
        if len(output1)!=0:
            count=count+1
    #print(count)
    #print(len(emcpackage))
    if len(emcpackage)==count:
        return("Nice")
    else:
        return("False")
    
