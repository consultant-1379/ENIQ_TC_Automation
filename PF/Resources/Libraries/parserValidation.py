from datetime import datetime
import os
import paramiko
def list_of_data(s,server,port,user,pwd):
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
    ssh_client.connect(server,port,user,pwd)
    ssh_file=ssh_client.open_sftp()
    f=f'/eniq/home/dcuser/{s}'
    print(f)
    with ssh_file.open(f,'r') as r:
        tempread=r.read()
    newlist=tempread.split()
    # with ssh_file.open(f,'r') as r:
    #     s=r.readlines()
    # #s.replace('\n','')
    # #print(s)
    # #s=s.split('\n')
    # #s.pop(-1)
    # #s.pop(-1)
    # #print(s)
    # datelist=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    # newlist=[]
    # c=0
    # while c < len(s):
    #     if '\t  ' in s[c]:
    #         s.insert(c, '\t \r')
    #         c += 1  # Skip the next element to avoid an infinite loop
    #     c += 1
    # #print(s)
    # sout=''
    # for i in s:
    #     i=i.strip()
    #     if i=='':
    #         newlist.append(sout)
    #         sout=''
    #     elif i[0:3] in datelist and ':' in i and '.000000' in i:
    #         i=i.split('.')[0].strip()
    #         date_obj=datetime.strptime(i,"%b %d %Y %H:%M:%S")
    #         output_date_string = date_obj.strftime('%Y-%m-%d %H:%M:%S')
    #         sout=sout+output_date_string      
    #     elif i[0:3] in datelist and ':' not in i and '.000000' not in i:
    #         i=i.strip()
    #         date_obj=datetime.strptime(i,"%b %d %Y")
    #         output_date_string = date_obj.strftime('%Y-%m-%d')
    #         sout=sout+output_date_string 
    #     else:
    #         sout=sout+i.strip()
    #newlist.pop(0)
    print(newlist)
    return newlist
def list_of_text(filepath):
    fileobj=open(filepath)
    i=fileobj.read()
    mainli=i.split()
    # for k in i:
    #     li=k.split('	')
    #     for t in li:
    #         mainli.append(t)
    # for j in range(len(mainli)):
    #     if mainli[j].strip() == '(null)':
    #         mainli[j] = 'NULL'
    #     mainli[j]=mainli[j].strip()
    # #print(li)
    #mainli[len(mainli)-1]=mainli[len(mainli)-1].replace('eniqs[eniq_stats] {dcuser} #:','')
    print(mainli)
    return mainli
def validation(li1,li2,sessionId,batchId):
    mismatchli=[]
    # if len(li1)!=len(li2):
    #     return False
    # text2=''
    # for i in li2:
    #     if i=='':
    #         continue
    #     else:
    #         text2=text2+i.strip()
    # for i in range(len(li1)):
        
    #     if li1[i].strip() not in text2:
    #         if (li1[i]=='' or li1[i]==sessionId or li1[i]==batchId):
    #             continue
    #         else:
    #             mismatchli.append(li1[i])
    if len(li1)!=len(li2):
        return 'notvalidated',mismatchli
    for i in range(len(li1)):
        if li1[i].strip().decode('utf-8')!=li2[i].strip():
            if li1[i].strip().decode('utf-8')==sessionId or li1[i].strip().decode('utf-8')==batchId or (':' in li1[i].decode('utf-8') and '.0' in li1[i].decode('utf-8')) or (li1[i].strip().decode('utf-8')=='(NULL)' and li2[i].strip()=='(null)'):
                continue
            else:    
                mismatchli.append(str(li1[i].decode('utf-8'))+ ' --- '+str(li2[i]))
    if mismatchli!=[]:
        return 'notvalidated',mismatchli
    return 'validated',mismatchli
    # text1=''
    # text2=''
    # for i in li1:
    #     if i=='':
    #         continue
    #     else:
    #         text1=text1+i.strip()
    # for i in li2:
    #     if i=='':
    #         continue
    #     else:
    #         text2=text2+i.strip()
    # print(text1)
    # print(text2)
    # mismatch1=''
    # mismatch2=''
    # for i in range(len(text1)):
    #     if text1[i]!=text2[i]:
    #         mismatch1=mismatch1+text1[i]
    #         mismatch2=mismatch2+text2[i]
    # return mismatch1+"  ---  "+mismatch2
#print()
def get_parser_and_techpack():
    fileobj=open(os.path.dirname(__file__)+"/techpackname.txt","r")
    li=fileobj.readlines()
    ParserTpDict={}
    #print(li)
    for i in li:
        temp=i.split('->')
        tempkey=temp[0]
        tempval=temp[1].split(',')
        ParserTpDict[tempkey]=tempval
    return ParserTpDict

###1###
# i=i.replace('','NULL')
# li=i.split()
# #print(li)
# li_res=[]
# for j in li:
#     j=j.replace('NULL','')
#     li_res.append(j)
# res_string=''
# for j in li_res:
#     if j=='':
#         res_string=res_string+"NULL"
#     else:
#         res_string=res_string+j
# print(res_string)

###2###
# i='''         0
#                    NULL'''
# print(i.split('\n'))