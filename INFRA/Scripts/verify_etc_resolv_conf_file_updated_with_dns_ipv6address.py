
import opensession_runcommand
import check_ip_type
cmd="cat /etc/resolv.conf | grep -w nameserver | grep -v \":\" | awk '{print $2}'"
def check_for_dns_ipv6_entry(hostname,user,pwd):
    ip_type = check_ip_type.check_iptype(hostname, user, pwd)
    if ip_type =="dualstack":
        output=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd)
        #print(output)
        if output:
            #print("True")
            return "True"
        else:
            #print("False")
            return "False"
    else:
        #print("True")
        return "True"
