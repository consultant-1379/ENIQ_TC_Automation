import glob
import os
import re
import time
from datetime import datetime
from functools import wraps
import paramiko

def NREL_filter(nrel_output,cell_output):
    nrel=nrel_output.split('\r\n')
    cell=cell_output.split('\r\n')
    del nrel[-2:]
    del cell[-2:]
    nrel=[i.strip() for i in nrel if i.strip()]
    cell=[i.strip() for i in cell if i.strip()]
    count1=0
    count2=0
    fail=[]
    flag=1
    if len(nrel)<1:
        print(len(nrel))
        return 0, f'DIM_E_GRAN_NETOP_CELL_NREL or DIM_E_GRAN_CELL table is empty. \n'
    else:
        for i in range(0,len(nrel)-2,3):
            for j in range(len(cell)-2):
                if nrel[i]==cell[j]:
                    if nrel[i+1] == cell[j+1] and nrel[i+2] == cell[j+2]:
                        count1+=1  
                      
                    else:
                        count2+=1
                        fail.append(nrel[i+2])
                        flag=0
        if count2==0:
            return flag, f"All {count1} values are matching."
        else:
            return flag, f'{count2} values below are not matching \n {fail}'


def compare_cell_and_netop_cell(cell_output, netop_cell_output):
    cell=cell_output.split('\r\n')
    netop_cell=netop_cell_output.split('\r\n')
    del cell[0:1]
    del cell[-2:]
    del netop_cell[-2:]
    cell=[i.strip() for i in cell if i.strip()]
    netop_cell=[i.strip() for i in netop_cell if i.strip()]
    cell=set(cell)
    netop_cell=set(netop_cell)
    not_present=[]
    flag=1
    if len(cell)<1:
        print(len(cell))
        return 0, f'DIM_E_GRAN_CELL or DIM_E_GRAN_NETOP_CELL table is empty. \n'
    else:
        if cell.issubset(netop_cell):
            return flag, f"All the values are matching."
        else:
            not_present=cell.difference(netop_cell)
            flag=0
            return flag, f'Values below are not matching. \n {not_present}'

def compare_bsctrc(bsc_output , trc_output , bsctrc_output):
    bsc=bsc_output.split(' ')
    trc=trc_output.split(' ')
    bsctrc=bsctrc_output.split(' ')
    del bsc[-5:]
    del trc[-5:]
    del bsctrc[-5:]
    bsc=[i.strip() for i in bsc if i.strip()]
    trc=[i.strip() for i in trc if i.strip()]
    bsctrc=[i.strip() for i in bsctrc if i.strip()]
    print(bsc)
    print(trc)
    print(bsctrc)
    bsc_trc=bsc+trc
    bsctrc=set(bsctrc)
    bsc_trc=set(bsc_trc)
    not_present=[]
    flag=1
    if len(bsctrc)<1:
        print(len(bsctrc))
        return 0, f'DIM_E_GRAN_BSCTRC or DIM_E_GRAN_TRC or DIM_E_GRAN_BSC table is empty. \n'
    else:
        if bsctrc==bsc_trc:
            return flag, f"All the values are matching."
        else:
            not_present=bsctrc.difference(bsc_trc)
            flag=0
            return flag, f'Values below are not matching. \n {not_present}'


def edit_epfg_for_NFMGroupMultiMeasObjLdn(server,port,user,password):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  f=f'/eniq/home/dcuser/epfg/config/epfg.properties'
  with ssh_file.open(f,'r') as r:
    txt=r.readlines()
  with ssh_file.open(f,'w') as w:
    for l in txt:
        if l.startswith('NFMGroupMultiMeasObjLdn='):
            x=re.sub('NO','YES',l)
            w.write(x)
            print(x)
        else:
            w.write(l)
def ccrc_moid(ccrc_moid, ccrc_moid_val):
    ccrc_moid=ccrc_moid.split('\r\n')
    ccrc_moid_val=ccrc_moid_val.split(' ')
    del ccrc_moid[-2:]
    del ccrc_moid_val[-5:]
    ccrc_moid=[i.strip() for i in ccrc_moid if i.strip()]
    ccrc_moid_val=[i.strip() for i in ccrc_moid_val if i.strip()]
    ccrc_moid=[i.split(',') for i in ccrc_moid]
    print(ccrc_moid_val)
    x=[]
    if len(ccrc_moid_val)<1:
        print(len(ccrc_moid_val))
        return 0, f'DC_E_CCRC_NRF_NNRF_NFM_RAW  table have empty moid key. \n'
    else:
        for i in range(len(ccrc_moid)):
            del ccrc_moid[i][0:1]
            del ccrc_moid[i][-1:]
            for j in range(len(ccrc_moid[i])):
                x+=ccrc_moid[i][j].split('=')
        y=[]
        for i in range(1,len(x),2):
            y.append(x[i])
        print(y)
        if ccrc_moid_val==y:
            return 1, f"All {len(ccrc_moid_val)} key values are matching in the MOID."
        else:
            ccrc_moid_val=set(ccrc_moid_val)
            y=set(y)
            z=ccrc_moid_val.difference(y)
            return 0, f'{len(z)} values below are not matching \n {z}'
        

def verify_netop_start_and_stop_time(repdb_table_output):
    repdb_table_output=repdb_table_output.split('\r\n')
    del repdb_table_output[-2:]
    repdb_table_output=[i.strip() for i in repdb_table_output if i.strip()]
    output2=[]
    for i in repdb_table_output:
        output2+=i.split('DC_E_NETOP:((35)):')
    for i in output2:
        if i=='':
            output2.remove(i)
    bar='BAR'
    res = [i for i in output2 if bar in i]
    mrr='MRR'
    res2 = [i for i in output2 if mrr in i]
    return res, res2

def verify_netop_start_and_stop_time1(NETOP_BAR_file_name):
    NETOP_BAR_file_name=NETOP_BAR_file_name.split('\n')
    return NETOP_BAR_file_name[0]

def verify_netop_start_and_stop_time2(output1, table_output):
    output1=output1.split('\n')
    output1=[i.split('\t') for i in output1]
    x=[]
    for i in output1:
        for j in i:
            if j!='':
                x.append(j)
    file_start_time=str(x[3])+' '+str(x[5])
    print("Recording start time in PM file is: " + file_start_time)
    y=x[5].split(':')
    stop_time_minutes=y[0]+':'+x[1]+':'+y[2]
    file_stop_time=str(x[3])+' '+str(stop_time_minutes)
    print("Recording stop time in PM file is: " + file_stop_time)

    table_output=table_output.split('\n')
    del table_output[-2:]
    table_output=[i.strip() for i in table_output if i.strip()]
    for i in table_output:
        table_output=i.split(' ')
    lst1=[]
    for i in table_output:
        if i !='':
            lst1.append(i)
    start_time=lst1[3].split('.')
    del start_time[-1]
    stop_time=lst1[7].split('.')
    del stop_time[-1]
    if str(x[5]).startswith('0'):
        start_time[0]='0'+str(start_time[0])
        stop_time[0]='0'+str(stop_time[0])
    lst2=lst1[2].split('20')
    lst1[2]=lst2[1]
    month_number={"Jan":'01', "Feb":'02','Mar':'03', 'Apr':'04', 'May':'05','Jun':'06','Jul':'07', 'Aug':'08', 'Sep':'09','Oct':10,'Nov':11, 'Dec':12}
    recording_start_time=str(lst1[2])+'/'+month_number[lst1[0]]+'/'+str(lst1[1])+' '+str(start_time[0])
    recording_stop_time=str(lst1[2])+'/'+month_number[lst1[0]]+'/'+str(lst1[1])+' '+str(stop_time[0])
    print("Recording start time in database is: " + recording_start_time)
    print("Recording stop time in database is: " + recording_stop_time)

    if file_start_time==recording_start_time and file_stop_time==recording_stop_time:
        print('Recording_start_time value and Recording_stop_time values in PM files are matching with database values')
        return 1
    else:
        print("fail")
        return 0

def verify_netop_start_and_stop_time3(output1, table_output):
    #PM file output filteration
    output1=output1.split('\n')
    output1=[i.split('\t') for i in output1]
    x=[]
    for i in output1:
        for j in i:
            if j!='':
                x.append(j)           
    file_start_time=str(x[1])+' '+str(x[3])
    print("Recording start time in PM file is: " + file_start_time)
    y=x[3].split(':')
    stop_time_minutes=y[0]+':'+x[5]+':'+y[2]
    file_stop_time=str(x[1])+' '+str(stop_time_minutes)
    print("Recording stop time in PM file is: " + file_stop_time)

    #Database output filteration
    table_output=table_output.split('\n')
    del table_output[-2:]
    table_output=[i.strip() for i in table_output if i.strip()]
    for i in table_output:
        table_output=i.split(' ')
    lst1=[]
    for i in table_output:
        if i !='':
            lst1.append(i)
    start_time=lst1[3].split('.')
    del start_time[-1]
    stop_time=lst1[7].split('.')
    del stop_time[-1]
    if str(x[3]).startswith('0'):
        start_time[0]='0'+str(start_time[0])
        stop_time[0]='0'+str(stop_time[0])
    lst2=lst1[2].split('20')
    lst1[2]=lst2[1]
    month_number={"Jan":'01', "Feb":'02','Mar':'03', 'Apr':'04', 'May':'05','Jun':'06','Jul':'07', 'Aug':'08', 'Sep':'09','Oct':10,'Nov':11, 'Dec':12}
    recording_start_time=str(lst1[2])+'/'+month_number[lst1[0]]+'/'+str(lst1[1])+' '+str(start_time[0])
    recording_stop_time=str(lst1[2])+'/'+month_number[lst1[0]]+'/'+str(lst1[1])+' '+str(stop_time[0])
    print("Recording start time in database is: " + recording_start_time)
    print("Recording stop time in database is: " + recording_stop_time)

    if file_start_time==recording_start_time and file_stop_time==recording_stop_time:
        print('Recording_start_time value and Recording_stop_time values in PM files are matching with database values')
        return 1
    else:
        print("fail")
        return 0
    
        
    


