import opensession_runcommand
import os
import paramiko
import get_client_ips_from_mws
def clients_in_etc_exports(hostname,user,pwd):
    ip_list = get_client_ips_from_mws.get_the_client_ips(hostname,user,pwd)
    #print(ip_list)
    flag=1
    for ip in ip_list:
        output=""
        output = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /etc/exports | grep "+ip)
        if(output==""):
            flag=0
            #print("Problem")
    if(flag==1):
        return("True")
    else:
        return("False")