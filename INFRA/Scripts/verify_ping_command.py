import opensession_runcommand


def ping_cmd_check(hostname,user,pwd,host_name):
    ping6_cmd='ping6 -c 3 {}'.format(host_name)
    ping_cmd='ping -c 3 {}'.format(host_name)
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=ping6_cmd)
    if 'No address associated with hostname' in output1:
        output2=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=ping_cmd)
        if '3 received' in output2:
            return 'True'
        else:
            return 'False'
    elif '3 received' in output1:
        return 'True'
    else:
       output2=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=ping_cmd)
       if '3 received' in output2:
           return 'True'
       else:
           return 'False'
