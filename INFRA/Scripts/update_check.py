
import opensession_runcommand
cmd1='ls -lrt /var/ericsson/log/patch/ | grep -v "pre_upgrade_patchrhel.bsh_YUM_*" | grep -i "pre_upgrade_patchrhel.bsh_*" | tail -1'
def update_check(hostname,user,pwd):
    file_name =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    file=file_name.split()[-1]
    cmd2="cat /var/ericsson/log/patch/{} | grep 'No packages to update'"
    cmd2=cmd2.format(file)
    op=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd2)
    if "No packages to update" in op:
        return "False"
    else:
        return "True"