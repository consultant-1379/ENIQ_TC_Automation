
import opensession_runcommand
import os
strg_path='/ericsson/storage/'
cmd1='dmidecode -t system | grep -i "Product Name"'
cmd2='cat /eniq/installation/config/SunOS.ini | grep -w "SAN_DEVICE"'
def check_rack_type(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if 'BL' in output1:
        output2=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd2)
        output2=output2.strip()
        if (output2=="SAN_DEVICE=vnx") or (output2=="SAN_DEVICE="):
            return 'not unity'
        else:
            return 'BL'
    elif 'DL' in output1:
        if os.path.exists(strg_path):
            return "Multi_Rack"
        else:
            return "simplex_Rack"
