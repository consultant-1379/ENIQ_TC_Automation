import getnetworkinterfaces
import opensession_runcommand
#commands to get the hardware address of network interface
command1 = "cat /etc/sysconfig/network-scripts/"
command2 = "|grep HWADDR | tail -1"
#commands to verify the hardware address
command3 = "cat /sys/class/net/"
command4 = "/address"
def check_networkinterfaces_configured(hostname,user,pwd):
    #open connection to server
    networkinterfaceslist = getnetworkinterfaces.get_network_interface_list(hostname, user, pwd)
    hwaddr_list=[]
    hwaddr_list_check=[]
    #create a list of hwaddr from network interface list
    for i in range (len(networkinterfaceslist)):
        hwaddr = opensession_runcommand.connect_to_terminal_runcommand(hostname, user, pwd, command = command1 + networkinterfaceslist[i] + command2)
        if len(hwaddr)==0:
            return("False")
            break
        else:
            hwaddr_list.append(hwaddr.partition("=")[2][:-1])
    #create a list of hwaddr from /sys/class/net/<interfacename>/address to verify the interface addresses stored in hwaddr_list
    for i in range (len(networkinterfaceslist)):
        hwaddr_check = opensession_runcommand.connect_to_terminal_runcommand(hostname, user, pwd, command = command3 + networkinterfaceslist[i].partition("-")[2] + command4)
        hwaddr_list_check.append(hwaddr_check.rstrip('\n'))

    #compare hwaddr_list and hwaddr_list_check to see if the hardware addresses are correct for the network interfaces
    if hwaddr_list==hwaddr_list_check:
        return("True")
    else:
        #print(hwaddr_list)
        #print(hwaddr_list_check)
        return("False")