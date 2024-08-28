import opensession_runcommand
import os
import paramiko
def check_etc_exports_updated_with_ipv6_details(hostname,user,pwd):
    emcpackage =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="ls -lrt /JUMP/LIN_MEDIA/1/kickstart/")
    new = emcpackage.split()
    j=0
    new_1=[]
    for i in range(0,len(new)):
        if "ieatrcx" in new[i]:
            new_1.append(new[i])
    flag=0
    for i in range(0,len(new_1)):
         ip_type = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /JUMP/LIN_MEDIA/1/kickstart/"+new_1[i]+"/"+new_1[i]+"_ks_cfg.txt | grep CLIENT_DEPLOY_TYPE")
         ip_type=ip_type.replace("CLIENT_DEPLOY_TYPE=","")
         ip_type=ip_type.replace("\n","")
         if(ip_type=="IPv6"):
             ip_addr = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="getent ahostsv6 "+new_1[i]+" | head -1 | awk '{print $1}'")
             ip_addr=ip_addr.replace("\n","")
             etc_exports_check=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /etc/exports | grep "+new_1[i])
             if ip_addr not in etc_exports_check:
                 flag=1
    if flag==0:
        return("True")
    else:
        rerurn("False")