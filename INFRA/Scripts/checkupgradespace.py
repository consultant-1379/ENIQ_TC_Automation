import opensession_runcommand


def check_memory_space(hostname,user,pwd):
    #open connection to server
    memoryspace = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="df -h")
    outputlist=memoryspace.split("\n")
    outputlines=[]
    #check space used under /JUMP
    jumpspace=0
    for i in range(len(outputlist)):
        outputlines.append(outputlist[i].split())
    for i in range(len(outputlines)-1):
        if outputlines[i][0].endswith("JUMP"):
            jumpspace=int(outputlines[i][4].replace("%",""))
    #check if used space in /JUMP is greater than 90(return False) or less than 90(return True)
    if jumpspace<=90:
        return("True")
    else:
        return("False")

