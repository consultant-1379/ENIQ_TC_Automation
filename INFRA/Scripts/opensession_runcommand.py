import paramiko
def connect_to_terminal_runcommand(host,username,password,command=''):
    client = paramiko.client.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect(host, username=username, password=password)
    stdin, stdout, stderr = client.exec_command(command)
    lines = stdout.read().decode()
    client.close()
    return(lines)
