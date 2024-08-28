import opensession_runcommand
cmd1='ls -lrt /var/ericsson/log/patch/ | grep "snapshot_deletion_" | tail -1'
def pre_cdb_check(hostname,user,pwd):
    file_name =  opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if not file_name:
        return "True"
    file=file_name.split()[-1]
    cmd2="cat /var/ericsson/log/patch/{} | grep 'This script will perform Snapshot deletion'"
    cmd2=cmd2.format(file)
    op=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd2)
    if "This script will perform Snapshot deletion" in op:
        return "False"
    else:
        return "True"