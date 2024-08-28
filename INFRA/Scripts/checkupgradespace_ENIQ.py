import opensession_runcommand


def check_memory_space(hostname,user,pwd):
    #open connection to server
    memoryspace = opensession_runcommand.connect_to_terminal_runcommand(host=hostname,username=user,password=pwd,command="df -h")
    outputlist=memoryspace.split("\n")
    outputlines=[]
    #check space used under /JUMP
    rootspace=0
    rootspacespace_str=""
    varspace=0
    varspace_str=""
    for i in range(len(outputlist)):
        outputlines.append(outputlist[i].split())
    for i in range(len(outputlines)-1):
        if outputlines[i][0].endswith("root"):
            rootspace_str = outputlines[i][3]
        elif outputlines[i][0].endswith("var"):
            varspace_str = outputlines[i][3]
    if varspace_str.endswith("M"):
        varspace = int(varspace_str.replace("M",""))
    if varspace_str.endswith("G"):
        varspace = int(varspace_str.replace("G",""))*1000
    if rootspace_str.endswith("M"):
        rootspace = int(rootspace_str.replace("M",""))
    if rootspace_str.endswith("G"):
        rootspace = int(rootspace_str.replace("G",""))*1000
    else:
        varspace = int(varspace_str)//1000
        rootspace = int(rootspace_str)//1000 
                    #int(outputlines[i][3].replace("%",""))
    #check if used space in /JUMP is greater than 90(return False) or less than 90(return True)
    if varspace>=20000 and rootspace>=20000:
        return("True")
    else:
        return("False")

