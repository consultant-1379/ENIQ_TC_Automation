import opensession_runcommand
cmd1='cat /etc/fstab | grep /home'
cmd2="cat /etc/fstab | grep ' /tmp'"
cmd3='cat /etc/fstab | grep /var/tmp'
def check_mount_parameters_enabled(hostname,user,pwd):
    output1=  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    output2=  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd2)
    output3=  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd3)
    if 'nodev' not in output1 or 'nodev,noexec,nosuid' not in output2 or 'nodev,noexec,nosuid' not in output3:
        return "False"
    else:
        return "True"
		
