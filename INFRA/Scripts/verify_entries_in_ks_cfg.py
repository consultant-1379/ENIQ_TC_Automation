import opensession_runcommand

def check_req_entries(hostname,user,pwd):
    flag=0
    ipv4='CLIENT_HOSTNAME=|CLIENT_DEPLOY_TYPE=|CLIENT_IP_ADDR=|CLIENT_NETMASK=|CLIENT_MAC_ADDR=|CLIENT_BOOT_MODE=|CLIENT_ARCH=|CLIENT_TZ=|CLIENT_DISP_TYPE=|CLIENT_APPL_TYPE=|CLIENT_APPL_MEDIA_LOC=|CLIENT_OM_LOC=|CLIENT_NET_ADDR=|CLIENT_KICK_LOC=|CLIENT_KICK_DESC=|CLIENT_INSTALL_PATCH_KICK_DESC=|CLIENT_INSTALL_PATCH_KICK_LOC=|CLIENT_INSTALL_PATCH_KICK_ID=|CLIENT_TIMESERVE=|CLIENT_DNSDOMAIN=|CLIENT_DNSSERVER=|CLIENT_GATEWAY=|CLIENT_INSTALL_PATCH_KICK_SPRINT=|CLIENT_INSTALL_PATCH_KICK_BUNDLE='
    ipv6='CLIENT_IP_ADDR_V6|ROUTER_IP_ADDR_V6|CLIENT_DNSSERVER_V6|CLIENT_DNSDOMAIN_V6|CLIENT_TIMESERVE_V6'
    ipv4_cmd='cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -E '+"'{}'".format(ipv4)
    ipv6_cmd='cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -E '+"'{}'".format(ipv6)
    deployment_type=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command='cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep "CLIENT_DEPLOY_TYPE="')
    if "IPv6" in deployment_type:
        ipv6_op=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command='cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt')
        ipv6_op=ipv6_op.split('\n')
        for i in ipv6_op:
            j=i.split('=')
            if len(j)>1 and not j[1]: 
                flag=1
    else:
        ipv4_op=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=ipv4_cmd)
        ipv4_op=ipv4_op.split('\n')
        for i in ipv4_op:
            j=i.split('=')
            if len(j)>1 and not j[1]:
                flag=1
    if flag==1:
        return "False"
    else:
        return "True"
