import opensession_runcommand
import os
import paramiko
def ipv6_entries_present_in_ks_cfg_file(hostname,user,pwd):
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
             output = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /JUMP/LIN_MEDIA/1/kickstart/"+new_1[i]+"/"+new_1[i]+"_ks_cfg.txt | grep -E 'CLIENT_IP_ADDR_V6|ROUTER_IP_ADDR_V6|CLIENT_DNSSERVER_V6|CLIENT_DNSDOMAIN_V6|CLIENT_TIMESERVE_V6'")
             output = output.replace("CLIENT_IP_ADDR_V6=","")
             output = output.replace("ROUTER_IP_ADDR_V6=","")
             output = output.replace("CLIENT_DNSSERVER_V6=","")
             output = output.replace("CLIENT_DNSDOMAIN_V6=","")
             output = output.replace("CLIENT_TIMESERVE_V6=","")
             output = output.split("\n")
             for j in range(0,5):
                 if(output[j]==""):
                     flag=1
    if(flag==0):
        return("True")
    else:
        return("False")