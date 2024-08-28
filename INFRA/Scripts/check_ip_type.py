import opensession_runcommand

active_interface_ipv4="ip -o -f inet addr show | awk '/scope global/ {print $2}'"
active_dynamic_ipv4='ip -o -f inet addr show | grep -w "dynamic"'

active_interface_ipv6="ip -o -f inet6 addr show | awk '/scope global/ {print $2}'"
active_dynamic_ipv6='ip -o -f inet6 addr show | grep -w "dynamic"'

def check_iptype(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=active_interface_ipv4)
    output2=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=active_dynamic_ipv4)
    output3=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=active_interface_ipv6)
    output4=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=active_dynamic_ipv6)

    if  output1 and (not output2 and not output3 and not output4):
        #print("ipv4")
        return "ipv4"
    elif (output1 and output3) and (not output2 and not output4):
        #print("dualstack")
        return "dualstack"
    else:
        #print("Server has No IP configuration")
        return "Server has No IP configuration"
