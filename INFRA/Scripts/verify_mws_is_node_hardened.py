import paramiko
cmd1="firewall-cmd --list-ports"
cmd2="firewall-cmd --list-service"

def nh(host,username,pwd):
    client=paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host,username=username,password=pwd)
    stdin,stdout,stderr=client.exec_command('systemctl status firewalld')
    status=stdout.read().decode()
    i=0
    if 'inactive (dead)' in status:
        stdin,stdout,stderr=client.exec_command('systemctl start firewalld')
        i=1
    stdin,stdout,stderr=client.exec_command(cmd1)
    op=stdout.read().decode()
    op=op.strip().split(" ")
    stdin,stdout,stderr=client.exec_command(cmd2)
    service_op=stdout.read().decode()
    service_op=service_op.strip().split(" ")
    if i==1:
        stdin,stdout,stderr=client.exec_command('systemctl stop firewalld')
    if len(op[0])>0 and service_op[0]!=" ":
        return "nh_applied"
    else:
        return "nh_not_applied"

