import opensession_runcommand
import os
cmd1='dmidecode -t system | grep -i "Product Name"'

def Verify_the_current_generation(hostname,user,pwd):
    output1=opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command=cmd1)
    if ('Gen8' in output1):
        return 'Gen8'
    elif ('Gen9' in output1):
        return 'Gen9'
    else:
        return 'Gen10/Gen10Plus'
           
