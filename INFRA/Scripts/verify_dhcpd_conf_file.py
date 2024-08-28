import opensession_runcommand
import check_ip_type
cmd="cat /etc/dhcp/dhcpd.conf  | grep  domain-name-servers"
def check_dhcpd_conf_file(hostname,user,pwd):
    ip_type = check_ip_type.check_iptype(hostname, user, pwd)
    if ip_type =="dualstack":
        op=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd)
        if (('159.107.173.3' in op) or ('159.107.173.12' in op) or ('159.107.173.5' in op)) and (':' not in op):
            return "True"
        else:
            return "False"
    else:
        return "True"
