
import opensession_runcommand

cmd="cat  /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -w \"CLIENT_DEPLOY_TYPE\" | cut -d'=' -f2-"
def check_client_ip_type(hostname,user,pwd):
    cmd1=cmd.format(hostname,hostname)
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if 'IPv6' in output1:
        return "IPv6"
    else:
        return "IPv4"
