import opensession_runcommand
import ip_decompression
def check_ip(output1,output2):
    op1=output1.split('/64')[0]
    if op1 in output2:
        return "True"
        #print("True")
    elif output1 in output2:
        return "True"
    else:
        op3=ip_decompression.decompress(op1)
        if op3 in output2:
            return "True"
            #print("true")
        else:
            #print("false")
            return "False"
#check_ip('2001:1b70:82b9:17d::c/64','2001:1b70:82b9:17d::c')
