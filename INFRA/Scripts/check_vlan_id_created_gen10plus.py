import re
import opensession_runcommand
cmd="dmidecode -t system | grep -w 'Product Name' | cut -d ':' -f2 | cut -d ' ' -f4,5"
command = "ip -o -f inet addr show | grep 'scope global'"
cmd2="cat /etc/sysconfig/network-scripts/ifcfg-{} | grep 'VLAN_ID'"
def get_vlan_details(hostname,user,pwd):
    #open connection to server
    c=[]
    networkinterfaces = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd)
    if "Gen10 Plus" in networkinterfaces:
        op = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=command)
        for i in op.splitlines():
            b=re.findall(r'bond.*',i.strip())[0]
            c.append(b.split()[0])
        for i in c:
            if i!="bond0":
                op = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd2.format(i.strip()))
                if not op.split("=")[-1]:
                    return "False"
                else:
                    continue
        else:
            return "True"
    else:
        return "True"