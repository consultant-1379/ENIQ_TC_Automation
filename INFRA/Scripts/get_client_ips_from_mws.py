import opensession_runcommand
import os
import paramiko
def get_the_client_ips(hostname,user,pwd):
    output = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="cat /etc/dhcp/dhcpd.conf | grep fixed-address")
    output = output.replace("   fixed-address ","")
    output = output.replace(";","")
    output1 = output.split()
    #['10.45.199.33', '10.45.199.39', '10.151.65.68', '10.45.194.181', '10.45.194.184', '10.45.194.187', '10.45.194.178', '10.45.197.183', '10.45.199.42']
    return(output1)