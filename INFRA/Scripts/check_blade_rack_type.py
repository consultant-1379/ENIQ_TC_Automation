import opensession_runcommand

cmd1='dmidecode -t system | grep -i "Product Name"'

def check_blade_rack_type(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if 'DL' in output1:
        return "DL"
    else:
        return "BL"
