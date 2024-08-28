
def decompress(p): 
    count=0
    # counting number of colons
    for i in range(0,len(p)):
        if(p[i]==":"):
            count = count + 1
 
    # Adding the required colons
    for i in range(0,len(p)):
        if(p[i]==":" and p[i+1]==":"):
            for j in range(0,(7-count)):
                p = p[:i] + ":" + p[i:]
            break
    s=""
    z=-1
    for i in range(0,len(p)):
        if(p[i]==":"):
            k = (i-z)
            for j in range (0,(5-k)):
                s = s + "0"
            s = s + p[z+1:i+1]
            z=i
        if(i==(len(p)-1)):
            k = (i-z)
            for j in range(0,(4-k)):
                s = s + "0"
            s = s + p[z+1:i+1]
    return(s)
