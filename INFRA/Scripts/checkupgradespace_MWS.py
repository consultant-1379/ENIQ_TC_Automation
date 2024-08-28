import opensession_runcommand


def check_memory_space(hostname,user,pwd):
    #open connection to server
    memoryspace = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="df -h")
    outputlist=memoryspace.split("\n")
    outputlines=[]
    #check space used under /JUMP
    jumpspace=0
    jumpspace_str=""
    for i in range(len(outputlist)):
        outputlines.append(outputlist[i].split())
    for i in range(len(outputlines)-1):
        if outputlines[i][0].endswith("JUMP"):
            jumpspace_str = outputlines[i][3]
    if jumpspace_str.endswith("M"):
        jumpspace = float(jumpspace_str.replace("M",""))
    elif jumpspace_str.endswith("G"):
        jumpspace = float(jumpspace_str.replace("G",""))*1000
    else:
        jumpspace = float(jumpspace_str)//1000
                   
    #check if used space in /JUMP is greater than 90(return False) or less than 90(return True)
    if jumpspace>=10000:
        return("True")
    else:
        return("False")


