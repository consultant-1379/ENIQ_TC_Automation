import opensession_runcommand
import os
import paramiko
import verify_latest_om_media
import verify_latest_release
hostname1="atrcxb2954"
user1="root"
pwd1="Infra#123"


def alpha_compare(a,b):
    if(len(a)>len(b)):
        flag = 1
    elif(len(a)<len(b)):
        flag=2
    else:
        for i in range(0,len(a)):
            if (a[i]>b[i]):
                flag=1
                break
            elif(a[i]<b[i]):
                flag=2
                break
            else:
                flag=0
                continue
    return(flag)


def rstate_compare(pkg1,pkg2):
    pkg1 = pkg1.replace("ERICnodehardening-R","")
    pkg2 = pkg2.replace("ERICnodehardening-R","")
    pkg1 = pkg1.replace(".rpm","")
    pkg2 = pkg2.replace(".x86_64","")
    pkg2 = pkg2.replace("-","")
    #print(pkg1)
    #print(pkg2)
    rstate1 = "".join(c for c in pkg1 if c.isalpha())
    rstate2 = "".join(c for c in pkg2 if c.isalpha())
    #print(rstate1)
    #print(rstate2)
    r_number1 = pkg1.split(rstate1)
    r_number2 = pkg2.split(rstate2)
    #print(r_number1)
    #print(r_number2)
    if(int(r_number1[0]) > int(r_number2[0])):
        return("first")
    elif(int(r_number1[0]) < int(r_number2[0])):
        return("second")
    else:
        flag = alpha_compare(rstate1,rstate2)
        if(flag==1):
            return("first")
        elif(flag==2):
            return("second")
        else:
            if(int(r_number1[1]) > int(r_number2[1])):
                return("first")
            elif(int(r_number1[1]) < int(r_number2[1])):
                return("second")
            else:
                return("same")

def node_hardening_rpm(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /ericsson/security/compliance/Reports/ | grep Compliance_Report.txt")
    if (len(emcpackage)!=0):
        sprint_value = verify_latest_om_media.check_emc_package_exist(hostname1,user1,pwd1)
        release_value = verify_latest_release.latest_release_value(hostname1,user1,pwd1)
        emcpackage1 =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls /JUMP/OM_LINUX_MEDIA/"+release_value+"/"+sprint_value+"/om_linux/security/ | grep ERICnodehardening")

        emcpackage2 =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="rpm -qa |grep ERICnodehardening")
        #print(emcpackage1)
        #print(emcpackage2)
        if (rstate_compare(emcpackage1,emcpackage2)=="first" or rstate_compare(emcpackage1,emcpackage2)=="same"):
            return("true")
        elif (rstate_compare(emcpackage1,emcpackage2)=="second"):
            return("false")
    else:
        return("true")
