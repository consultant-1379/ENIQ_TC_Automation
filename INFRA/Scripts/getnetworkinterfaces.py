import opensession_runcommand
command = "ls /etc/sysconfig/network-scripts/|grep ifcfg"
def get_network_interface_list(hostname,user,pwd):
    #open connection to server
    networkinterfaces = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=command)
    networkinterfacestmp = networkinterfaces.split("\n")
    networkinterfaceslist1 = []
    #remove loopback(lo) entry from interface list
    for i in networkinterfacestmp:
        if "lo" in i:
            continue
        elif ".bak" in i:
            continue
        else:
            networkinterfaceslist1.append(i)
    networkinterfaceslist = list(filter(None, networkinterfaceslist1))
    return(networkinterfaceslist)