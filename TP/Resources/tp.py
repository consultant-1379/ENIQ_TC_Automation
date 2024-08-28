import glob
import os
import re
import time
from datetime import datetime
from functools import wraps
import paramiko
import numpy as np

def dependent_pkg_and_intf(techpack: str, output: str):
    b = output.split('\n')
    val = [f'.{techpack}.']
    dep_interfaces=[]
    for w in b:
        a = w.strip()
        if a.startswith('INTF'):
            val.append(a)
            dep_interfaces.append(a)
    return val, dep_interfaces

def dependent_pkg_and_intf_ERBS(techpack: str, output: str):
    b = output.split('\n')
    val = [f'.{techpack}.']
    dep_interfaces=["INTF_DC_E_ERBSG2"]
    for w in b:
        a = w.strip()
        if a.startswith('INTF'):
            val.append(a) 
            dep_interfaces.append(a)
            # print(val)
            # print(dep_interfaces)
           # dep_interfaces.append("INTF_DC_E_CCDM")
    return val, dep_interfaces  
    
def dependent_pkg_and_intf_vpp(techpack: str, output: str):
    b = output.split('\n')
    val = [f'.{techpack}.']
    dep_interfaces=["INTF_DC_E_NR"]
    for w in b:
        a = w.strip()
        if a.startswith('INTF'):
            val.append(a) 
            dep_interfaces.append(a)
            # print(val)
            # print(dep_interfaces)
           # dep_interfaces.append("INTF_DC_E_CCDM")
    return val, dep_interfaces 
              
def dependent_pkg_and_intf_cudb(techpack: str, output: str):
    b = output.split('\n')
    val = [f'.{techpack}.']
    dep_interfaces=["INTF_DC_E_CCDM"]
    for w in b:
        a = w.strip()
        if a.startswith('INTF'):
            val.append(a) 
            dep_interfaces.append(a)
            # print(val)
            # print(dep_interfaces)
           # dep_interfaces.append("INTF_DC_E_CCDM")
    return val, dep_interfaces
def edit_epfg_for_bulk_cm(server,port,user,password,date):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  f=f'/eniq/home/dcuser/epfg/config/epfg.properties'
  with ssh_file.open(f,'r') as r:
    txt=r.readlines()
  with ssh_file.open(f,'w') as w:
    gtime="genTime="+date
    for l in txt:
        if l.startswith('ValidateCounterValues='):
            x=re.sub('NO','YES',l)
            w.write(x)
            print(x)
        if "genTime=" in l:
            l=gtime
            #x=w.write(l)
            #print(x)
        if l.startswith('ENIQ_VOLUME_MT_POINT='):
            x=re.sub('/eniq/data/pmdata/eniq_oss_1/','/eniq/data/pmdata/eniq_oss_1/;/eniq/data/pmdata/eniq_oss_2/',l)
            w.write(x)
            print(x)
        else:
            w.write(l)

def tpi_file_loc_interface():
    '''Returns the latest downloaded .tpi file name 
    '''
    global q
    myhost = os.getenv('username')
    downloadspath = f'/root/intf'
    list_of_files = glob.glob(downloadspath+"/*.tpi")
    latest_file = max(list_of_files, key=os.path.getctime)
    q = latest_file.split('/')[-1]
    # print(q)
    return q    


def get_table_names(techpack, output):
    """
    Parameters
    ----------
    * `techpack`: Give variable that contains `TechPack` name.

    * `output`: Give variable name that contains output of `Sql query` to get table names.

    Example
    -------
    ${table_names}    Get Table Names    ${techpack_name}    ${output}
    """
    b = output.split('\n')
    dep_interfaces = []
    for w in b:
        a = w.strip()
        if a.startswith(techpack):
            dep_interfaces.append(f'Aggregator_{a}')
    return dep_interfaces


def adapter_activate(interface_name,parser):
    oss = f'{interface_name}-eniq_oss_1'
    adapter = f'Adapter_{interface_name}_{parser}'
    return oss, adapter


def timetaken(func):
    @wraps(func)
    def calc_time(*args, **kwargs):
        start_time = time.perf_counter()
        result = func(*args, **kwargs)
        end_time = time.perf_counter()
        total_time = end_time - start_time
        print(f'Function {func.__name__} took {total_time:.8f} seconds')
        return result
    return calc_time


def tpi_file_loc():
    '''Returns the latest downloaded .tpi file name 
    '''
    global q
    myhost = os.getenv('username')
    downloadspath = f'/root/sa'
    list_of_files = glob.glob(downloadspath+"/*.tpi")
    latest_file = max(list_of_files, key=os.path.getctime)
    q = latest_file.split('/')[-1]
    # print(q)
    return q


@timetaken
def kpi_file_transfer(package, serv):
    ssh_client = paramiko.SSHClient()
    server = f'atvts{serv}.athtem.eei.ericsson.se'
    port = 2251
    user = 'dcuser'
    password = 'Dcuser12#'
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        ssh_client.connect(server, port, user, password)
        print('Connection established successfully')
        ssh_transfer = ssh_client.open_sftp()
        path = r'/eniq/sw/installer/BO' + datetime.now().strftime('%d%b-%H%M%S')
        ssh_transfer.mkdir(path)
        print(f'Directory- {path} created')
        ssh_transfer.put(f'H://Downloads//{package}', f'{path}//{package}')
        print(f'File {package} transferred to {path} Successfully')
    except Exception as e:
        print("Error is= ", e)
    finally:
        ssh_transfer.close()
        ssh_client.close()
        print('All Connections are Closed')


@timetaken
def engine_log_check(host, portno, uname, passwrd, tp_name):
    flag = True
    ssh_client = paramiko.SSHClient()
    server = host
    port = portno
    user = uname
    password = passwrd
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    engine_log_path = f'/eniq/log/sw_log/engine/{tp_name}'
    tp_installer_path = r'/eniq/log/sw_log/tp_installer'
    try:
        engine = 0
        tp_inst = 0
        found_pkg = 0
        keywords = [' SEVERE ', ' EXCEPTION ',
                    ' ERROR ', ' FAILED ', ' SKIP ', ' WARNING ']
        ssh_client.connect(server, port, user, password)
        sftp_obj = ssh_client.open_sftp()
        sftp_obj.chdir(engine_log_path)
        for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
            if f.filename.endswith('.log'):
                a = f.filename
                break
        with sftp_obj.open(a) as f:
            f.prefetch()
            buffer = f.readlines()
            for keyword in keywords:
                for i, line in enumerate(buffer):
                    if re.search(keyword, line, re.IGNORECASE):
                        print(
                            f"<{keyword}> found in line {i+1} of engine log file")
                        engine = 1
                        flag = False
        b = []
        lim = 10
        sftp_obj.chdir(tp_installer_path)
        for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
            if f.filename.endswith('tp_installer.log'):
                b.append(f.filename)
                lim -= 1
                if lim == 0:
                    break
        if b:
            for i in b:
                with sftp_obj.open(i) as f:
                    f.prefetch()
                    buffer = f.readlines()
                    for line in buffer:
                        if re.search(f'^{tp_name}$', line, re.IGNORECASE):
                            found_pkg = 1
                            tp_inst_file = i
                            break
                    else:
                        continue
                    break
            if found_pkg == 1:
                with sftp_obj.open(tp_inst_file) as f:
                    f.prefetch()
                    buffer = f.readlines()
                    for keyword in keywords:
                        for i, line in enumerate(buffer):
                            if re.search(keyword, line, re.IGNORECASE):
                                print(
                                    f"<{keyword}> found in line {i+1} of tp_installer log file")
                                tp_inst = 1
                                flag = False
            else:
                print(f"{tp_name} not found in any tp_installer log files")
        else:
            print("No tp_installer log file found")
        if engine == 0:
            print(
                f'No keywords found in file {a} under path-> {engine_log_path}')
        if engine == 1:
            print(
                f'Some keywords found in file {a} under path-> {engine_log_path}')
        if tp_inst == 1:
            print(
                f'Some keywords found in file {tp_inst_file} under path-> {tp_installer_path}')
    except paramiko.ssh_exception.AuthenticationException:
        print("Error establishing Connection with the server, Check the Server name, Port, User and Password")

    except Exception as e:
        print("Error is= ", e)

    else:
        sftp_obj.close()
        ssh_client.close()
        print('Connection Closed')
    return flag


def setting_to_finest(ax,host):
    port = 2251
    uname = 'dcuser'
    pwd = 'Dcuser%12'
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(host, port, uname, pwd)
    ssh_transfer = ssh_client.open_sftp()
    path = r'/eniq/sw/conf/engineLogging.properties'
    print('Connection established successfully')
    content = []
    with ssh_transfer.open(path, 'r') as f:
        f.prefetch()
        con = f.readlines()
    for l in con:
        if 'FINEST' in l:
            b = re.sub('FINEST', 'INFO', l)
            content.append(b)
            print(b)
        else:
            content.append(l)
    with ssh_transfer.open(path, 'w') as w:
        for l in content:
            for intf in ax:
                if intf in l:
                    a = re.sub('INFO', 'FINEST', l)
                    print(a)
                    w.write(a)
                    break
            else:
                w.write(l)
def get_indir_value(output):
    a = output.splitlines()
    for i in a:
        if 'outDir' in i:
            b = i.split('/')
            c = list(filter(None, b))   
    return c[-1]
def filter_name(str):
  strarr = str.split('\r\n')
  return strarr[0].strip()
# host=    'atvts4095.athtem.eei.ericsson.se'
# port=    2251
# uname=     'dcuser'
# pwd=       'Dcuser%12'
# package=    'DC_E_CCRC'
# engine_log_check(host, port,uname,pwd,package)
def edit_epfg_for_counter_validation_n_multiple_oss(server,port,user,password):
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
        if l.startswith('ValidateCounterValues='):
            x=re.sub('NO','YES',l)
            w.write(x)
            print(x)
        # if l.startswith('ENIQ_VOLUME_MT_POINT='):
        #     x=re.sub('/eniq/data/pmdata/eniq_oss_1/','/eniq/data/pmdata/eniq_oss_1/;/eniq/data/pmdata/eniq_oss_2/',l)
        #     w.write(x)
        #     print(x)
        else:
            w.write(l)

def BT_FT_validation(s):
    li=s.split('\n')
    mainli=[]
    for i in li:
        if  'PASS-' in i and 'FAIL- ' in i and 'No_Data- ' in i:
            mainli.append(i)
    #print(mainli)
    failchecklist=[]
    passchecklist=[]
    for i in mainli:
        if 'FAIL- 0 No_Data- 0' in i:
            passchecklist.append(i.split(':')[0])
        else:
            failchecklist.append(i.split(':')[0])
    print(failchecklist)
    print(passchecklist)

def get_table_list(s):
    tablelist=s.split('\n')
    tablelist.pop(-1)
    tablelist.pop(-1)
    tablelist.pop(-1)
    for i in range(0,len(tablelist)):
        tablelist[i]=tablelist[i].strip().split(':')[2]
    return tablelist

def validate_delta(s1,s2,c1,c2,d):
    #print(((int)(c2)%8))
    #print((8-((int)(c1)/8)))
    #print(((int)(c2)%8)==(8-((int)(c1)/8)))
    if ((int)(d)==0):
        if(s1==s2 and (int(c1)==int(c2)-1)):
            return "true"
    if (s1==s2 and (int(c1)==int(c2))):
        return "true"
    return "false"

def get_counter_list(s):
    tablelist=s.split('\n')
    tablelist.pop(-1)
    tablelist.pop(-1)
    tablelist.pop(-1)
    for i in range(0,len(tablelist)):
        tablelist[i]=tablelist[i].strip()
    return tablelist

def validate_peg_gauge_delta(s,s1,ctype,sup):
    ar=s.split('\n')
    #print(tablelist)
    ar.pop(-1)
    ar.pop(-1)
    ar.pop(-1)
    for i in range(0,len(ar)):
        ar[i]=ar[i].strip()
    ar1=s1.split('\n')
    #print(tablelist)
    ar1.pop(-1)
    ar1.pop(-1)
    ar1.pop(-1)
    for i in range(0,len(ar1)):
        ar1[i]=ar1[i].strip()
    if(sup=='0'):
        print(ar,ar1)
        return ar==ar1
    if(len(ar)>1):
        if 'NULL' in ar:
            return True
        if '.' in ar[0]:
            for i in range(0,len(ar)):
                ar[i]=float(ar[i])
        else:
            for i in range(0,len(ar)):
                ar[i]=int(ar[i])
    if(len(ar1)>1):
        if '.' in ar1[0]:
            for i in range(0,len(ar1)):
                if 'NULL'!=ar1[i]:
                    ar1[i]=float(ar1[i])
        else:
            for i in range(0,len(ar1)):
                if 'NULL'!=ar1[i]:
                    ar1[i]=int(ar1[i])
    n=int(len(ar)/8)
    n1=int(len(ar1)/7)
    #print(n1)
    res=[]
    for i in range(0,n1):
        li=[]
        j=i
        while(j<len(ar1)):
            if(ar1[j]=='NULL'):
                li.append('NULL')
            else:
                li.append(ar1[j])
            j=j+n1
        res.append(li)
    print('delta array from db->',res)
    deltalist=[]
    if ctype=='PEG':
        for i in range(0,n):
            li=[]
            j=i
            while(j<len(ar)-n):
                if(ar[j+n]-ar[j]<0):
                    li.append('NULL')
                else:
                    li.append(ar[j+n]-ar[j])
                j=j+n
            #print(li)
            deltalist.append(li)
        print('delta list should be->',deltalist)
        return deltalist==res
    if ctype=='GAUGE':
        for i in range(0,n):
            li=[]
            j=i
            while(j<len(ar)-n):
                j=j+n
                li.append(ar[j])
            print(li)
            deltalist.append(li)
        return deltalist==res
        
                


#RAVI CODE STARTS FROM HERE

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
    
################# END ##############
def edit_epfg_for_cudbenmpmfile(server,port,user,password):
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
        if l.startswith('ENIQ_VOLUME_MT_POINT='):
            x=re.sub('/eniq/data/pmdata/eniq_oss_1/','/eniq/data/pmdata/eniq_oss_1/;/eniq/data/pmdata/eniq_oss_2/',l)
            w.write(x)
            print(x) 
                       
        else:
            w.write(l) 
     
              

def setting_to_finest_CUDB(ax,host):
    port = 2251
    uname = 'dcuser'
    pwd = 'Dcuser%12'
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(host, port, uname, pwd)
    ssh_transfer = ssh_client.open_sftp()
    path = r'/eniq/sw/conf/engineLogging.properties'
    print('Connection established successfully')
    content = []
    with ssh_transfer.open(path, 'r') as f:
        f.prefetch()
        con = f.readlines()
    for l in con:
        if 'FINEST' in l:
            b = re.sub('FINEST', 'INFO', l)
            content.append(b)
            print(b)
        else:
            content.append(l)
    with ssh_transfer.open(path, 'w') as w:
        for l in content:
            #for intf in ax:
            if 'INTF_DC_E_CUDB_ECIM' in l:
                    a = re.sub('INFO', 'FINEST', l)
                    print(a)
                    w.write(a)
                    #break
            else:
                w.write(l)

def filter_interfaces(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip())
  topotp = list(set(topotp))
  return topotp

def get_parser_value(output):
    return output.split('\n')[0].strip()
    


def compare_node_versions(rbs_output, rbsg2_output):
    # print(rbs_output)
    # print(rbsg2_output)
    rbs=rbs_output.split('\r\n')
    rbsg2=rbsg2_output.split('\r\n')
    #del rbs[0:1]
    del rbs[-2:]
    del rbsg2[-2:]
    rbs=[i.strip() for i in rbs if i.strip()]
    rbsg2=[i.strip() for i in rbsg2 if i.strip()]
    rbs=set(rbs)
    rbsg2=set(rbsg2)
    if rbsg2.issubset(rbs):
        print('All Values in rbsg2 is present in rbs')
    else:
        not_present=rbsg2.difference(rbs)
        print('Values not present in RBS are:')
        print(list(not_present))

def build_number(RBS_buildno):
    RBSbuildno=RBS_buildno.split('_b')[1].split('.t')[0]
    return RBSbuildno

def RBSG2_build_number(RBSG2_buildno):
    RBSG2buildno=RBSG2_buildno.split('_b')[1].split('.t')[0]
    return RBSG2buildno


def ERBS_build_number(ERBS_Nodeversion):
    ERBSbuildno=ERBS_Nodeversion.split('_R')[1].split('_b')[1].split('.t')[0]
    print(ERBSbuildno)
    return ERBSbuildno





def compare(ERBS,check):
    rbs=ERBS.split('\r\n')
    rbsg2=check.split('\r\n')
    # print(ERBS)
    # print(check)
    rbs=[i.strip() for i in rbs if i.strip()]
    rbsg2=[i.strip() for i in rbsg2 if i.strip()]
    del rbs[-2:]
    del rbsg2[-2:]
    Erbs=set(rbs)
    HW_Series=set(rbsg2)
    if Erbs.issubset(HW_Series):
        flag=True
        return flag,f'ERBS/ERBSG2 latest Node version added  in HW_SERIES'
    else:
        flag=False
        return flag,f'ERBS/ERBSG2 latest Node version not present:'
        




def get_latest_release(check_nodes):
    latest_version=check_nodes.split('    ')[0]
    latest_version1=latest_version.lstrip()
    print(latest_version1)
    return latest_version1

def mapping_or_not(mapping):
    if "eniq_oss_2=ENM" in mapping:
        flag=True
        return flag,f'ENM MAPPING'
    else:
        flag=False
        return flag,f'ENM NOT MAPPING'
    
def verify_RBSG2(mapping):
    
    if 'DC_E_RBSG2' in  mapping:
        flag=True
        return flag,f'RBS view definition contains both RBS and RBSG2'
    else:
        flag=False
        return flag,f'RBSG2 not present:'
    

def verify_key(cudb): 
    s=re.search(r'=(CUDB\w+)_',cudb)
    if s:
        return s.group(1)
    
# cudb='A20230417.1000+0200-1015+0200-CUDBSYST1-SERVFEAT_SubNetwork=Sub1,NetworkElement=CUDB01_statsfile.xml'
def verify_key1(cudb): 
    s=re.search(r'-(CUDB\w+)-',cudb)
    # print(s)
    if s:
        return s.group(1)
   # cud=cudb.split(',')[0].split('-')[2]
    # cud=cudb.split('-')[2]
    # print (cud)
# verify_key1(cudb) 

#   return 



# fg(outputone)
    
     

    

def compare_releases(latest_output,prev_release_output):
    latest_output=[i.strip() for i in latest_output if i.strip()]
    prev_release_output=[i.strip() for i in prev_release_output if i.strip()]
    Erbs=set(latest_output)
    HW_Series=set(prev_release_output)
    if Erbs:
        if Erbs==HW_Series:
            flag=True
            return flag,f'Prev node version hardware series data match with new hardware series data.'
        if HW_Series.difference(Erbs):
            flag=True
            return flag,f'Prev node version hardware series data match with new hardware series data and more entry for the new node version'
    else:
        if Erbs!=HW_Series:
            flag=False
            return flag,f'not matched'
        if Erbs.difference(HW_Series):
            flag=False
            return flag,f'less entry for the new node version'

def convert_list(list):
    list1=list.split('\r\n')
    list12=[i.strip() for i in list1 if i.strip()]
    list3=set(list12)
    return list3


def checking(output,prev_reflect_result):
    latest_output=[i.strip() for i in output if i.strip()]
    prev_release_output=[i.strip() for i in prev_reflect_result if i.strip()]
    Erbs=set(latest_output)
    HW_Series=set(prev_release_output)
    if Erbs:
        if Erbs==HW_Series:
            flag=True
            return flag,f'reflected'
    else:
        if Erbs!=HW_Series:
            flag=False
            return flag,f'not reflected'


    #    Sat Apr  8 18:08:19 BST 2023
     



def verify_mixed_standlone_mode(output1,output2):
    print(output1)
    print(output2)
    
    if output1==output2:
        flag=True
        return flag,f'mixedmode verified'
    else:
        flag=True
        return flag,f'standlonemode'
def deletelastrows(output):
    z="".join(output.split("\n")[:-2]) 
    return z
def deletelastrows3(output):
    z="".join(output.split("\r\n")[:-3]) 
    return z

def compare_rbsg2_rbs_description(rbsg2,rbs):
    rbsg2=set(rbsg2)
    rbs=set(rbs)
    if rbsg2.issubset(rbs):
        flag=True
        return flag,f'rbsg2 desprition is present in rbs'
        # print('rbsg2 desprition is present in rbs')
    else:
        not_present=rbsg2.difference(rbs)
        flag=False
        print(list(not_present))
        return flag,f'rbsg2 desprition not present in RBS are:'
        # print('rbsg2 desprition not present in RBS are:')
# rbsbuildnumber=330       
def prev_build_number(rbsbuildnumber):
    list=int(rbsbuildnumber)
    prev=list - 1
    print(prev)
    return prev  
# prev_build_number(rbsbuildnumber)

# output1=['cudb_system not found.']
# output2=['cudbsyst1']
def verify_sql_cudb_key(output1,output2,output3):
    # print(output1)
    # print(output2)
    if output1 == output3:
        flag=True
        return flag,f'CUDB_SYSTEM key value Matched'
    elif  output2 == True:
         flag=True
         return flag,f'CUDB_SYSTEM column not found'
    
    else:
         flag=False
         return flag,f'CUDB_SYSTEM key value not Matched'
        
# verify_sql_cudb_key(output1,output2)
def return_true_false(output: str):
  return output.split('\r\n')[len(output.split('\r\n'))-2]

def changing_bt_ft_file(server,port,user,password):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  f=f'/eniq/home/dcuser/BT-FT_Script/BT-FT_script.sh'
  endwithrn=0
  with ssh_file.open(f,'r') as r:
    arr=r.readlines()
  if('\r\n' in arr[0]):
    endwithrn=1
  print(arr)
  if(endwithrn==1):
    temp1='perl /eniq/home/dcuser/BT-FT_Script/BT-FT_txt_creator.pl;\r\n'
    temp2='''perl -lpe 's/^\s*(.*\S)\s*$/$1/' data.txt > data.tmp && mv data.tmp data.txt;\r\n'''
    temp3='''perl -pi -e 'chomp if eof' data.txt;\r\n'''
    for i in range(0,len(arr)):
        if(arr[i]==temp1):
            indextoremove=i
        if("You have chosen $input" in arr[i]):
            indextoadd=i+1
            break
  else:
    temp1='perl /eniq/home/dcuser/BT-FT_Script/BT-FT_txt_creator.pl;\n'
    temp2='''perl -lpe 's/^\s*(.*\S)\s*$/$1/' data.txt > data.tmp && mv data.tmp data.txt;\n'''
    temp3='''perl -pi -e 'chomp if eof' data.txt;\n'''
    for i in range(0,len(arr)):
        if(arr[i]==temp1):
            indextoremove=i
        if("You have chosen $input" in arr[i]):
            indextoadd=i+1
            break
  arr.insert(indextoadd,temp1)
  arr.insert(indextoadd+1,temp2)
  arr.insert(indextoadd+2,temp3)
  arr.pop(indextoremove)
  arr.pop(indextoremove)
  arr.pop(indextoremove)
  with ssh_file.open(f,'w') as w:
    for l in arr:
        w.write(l)

def afg_specific(server,port,user,password,datevar):
 ssh_client = paramiko.SSHClient()
 filenamelist=[]
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/archive/eniq_oss_1/AFG_ECIM/processed'
 result=True
 print(path)
 try:
     
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     c=0
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if not f'INTF_DC_E_AFG_{datevar}' in f.filename:
          return False
         if f'INTF_DC_E_AFG_{datevar}' in f.filename:
          filenamelist.append(f.filename)
          c=c+1
     if c!=8:
      return False
     
     for filename in filenamelist:
        filepath=f'/eniq/archive/eniq_oss_1/AFG_ECIM/processed/{filename}'
        with sftp_obj.open(filepath,'r') as f:
            f.prefetch()
            li=f.readlines()
            #li=s1.split()
            #print(li)
            timevar1=filename.split('.')[1]
            timevar2=str((int)(timevar1) +15)
            if timevar1=='1045':
              timevar2='1100'
            if timevar1=='1145':
              timevar2='1200'
            #print(timevar1,timevar2)
            for i in li:
                i=i.strip()
                templi=i.split('_')
                if templi[0] != f'A{datevar}.{timevar1}+0200-{timevar2}+0200':
                    result=False
                    #print(f'A{datevar}.{timevar1}+0200-{timevar2}+0200' == 'A20230328.1000+0200-1015+0200')
                    print(i,templi[0])
                    break
                if not (templi[1].startswith('SubNetwork=SubNetwork,NetworkElement=vAFG')):
                    result=False
                    print(i,templi[1])
                    break
                if templi[2]!=f'{datevar}-{timevar1}':
                    result=False
                    print(i,templi[2])
                    break
                if templi[3]!='statsfile.tar.gz':
                    result=False
                    print(i,templi[3])
                    break
                if (not templi[4].startswith(f'A{datevar}.{timevar1}+0200-{timevar2}+0200-') or ( templi[4].endswith('-'))):
                    result=False
                    print(i,templi[4])
                    break
                if (not templi[5].endswith('.xml')) or (not 'vAFG' in templi[5]) or (templi[5].startswith('.')):
                    result=False
                    print(i,templi[5])
                    break
    #  with sftp_obj.open(a) as f:
    #      f.prefetch()
    #      buffer = f.readlines()
    #      for keyword in keywords:
    #          for i, line in enumerate(buffer):
    #              if re.search(keyword, line, re.IGNORECASE):
    #                  print(f'{keyword} found in->',line)
    #                  engine=1
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '


def adapter_activate1(interface_name,parser):
    oss = f'{interface_name}-eniq_oss_2'
    adapter = f'Adapter_{interface_name}_{parser}'
    return oss, adapter

def transfer_to_server(file, server:str,user:str,password:str):
  '''Takes filename to transfer, server name, username and password as input
  '''
  print(file)  
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
      ssh_client.connect(server,port,user,password)
      print('Connection established successfully')
      ssh_transfer=ssh_client.open_sftp()
      path=r'/eniq/home/dcuser/'
      #ssh_transfer.mkdir(path)
      print(f'Directory- {path} created')
      ssh_transfer.put(f'H://Downloads//{file}', f'{path}//{file}')
      print(f'File {file} transferred to {path} Successfully' )
      ssh_client.exec_command(f'mv {file}  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'unzip  BT_FT_Script.zip ')
      #ssh_client.exec_command(f'cd  BT-FT_Script/ ')
      #ssh_client.exec_command(f'pwd')

  except Exception as e:
    print("Error is= ",e)
  finally:
      ssh_transfer.close()
      ssh_client.close()
      print('All Connections are Closed')

def filter_topotp_name(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      topotp.append(strarr[i].strip())
  topotp = list(set(topotp))
  return topotp

def filter_topotp(str):
  strarr=str.split('\r\n')
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      return strarr[i].strip()
  return " "

def filter_interface_name(str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  topotp = list(set(topotp))
  return topotp

def int_and_dim_name(dimpkg,str):
  strarr=str.split('\r\n')
  topotp=[]
  topotp.append(dimpkg[0])
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INT')):
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  return topotp

def filter_intf_name(tpname:str,str,server:str,user:str,password:str):
  strarr=str.split('\r\n')
  topotp=[]
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' INTF') or strarr[i].startswith(' DIM') ):
      topotp.append(strarr[i].strip())
      topotp.append(strarr[i].strip()+'-eniq_oss_1')
  topotp.append(tpname)
  topotp = list(set(topotp))
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_transfer=ssh_client.open_sftp()
  path=f'/eniq/sw/conf/engineLogging.properties'
  print('Connection established successfully')
  content=[]
  with ssh_transfer.open(path,'r') as f:
   f.prefetch()
   con=f.readlines() 
  for l in con:
    if 'FINEST' in l:
        b=re.sub('FINEST','INFO',l)
        content.append(b)
        print(b)
    else:
        content.append(l)
  with ssh_transfer.open(path,'w') as w:
   for i,l in enumerate(content):
      for intf in topotp:
         if intf in l:
            if 'INFO' in l:
               a=re.sub('INFO','FINEST',l)
               print(a)
               w.write(a)
               break
            else:
               continue
      else:
         w.write(l)
  return topotp

def activate_interface():
  server_number='4119'
  ssh_client = paramiko.SSHClient()
  server = f'atvts{server_number}.athtem.eei.ericsson.se'
  port = 2251
  user = 'dcuser'
  password = 'dcuser'
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
      ssh_client.connect(server,port,user,password)
      print('Connection established successfully')
      
      stdin,stdout,stderr =ssh_client.exec_command('cd /eniq/sw/installer ; ./activate_interface -o eniq_oss_1 -t DIM_E_CN')
      output = stdout.read()
      print(output)
  except Exception as e:
    print("Error is= ",e)
  finally:
      ssh_client.close()
      print('All Connections are Closed')

def filter_topotable_name(str):
  strarr=str.split('\r\n')
  topotp=''
  for i in range(0,len(strarr)):
    if(strarr[i].startswith(' DIM')):
      topotp=strarr[i].strip()
  return topotp

def filter_node_name(str):
  strarr=str.split('\r\n')
  return strarr[0].strip()

def filter_latest_name(str):
  strarr=str.split('\r\n')
  s1=''
  for i in strarr:
    if i=='':
      break
    s1=i.strip()
  return s1

def filter_date_from_epfg(str):
  strarr=str.split("\r\n")
  for l in strarr:
    if l.startswith("newendtime is"):
      return l.split("=")[1]
  return " "

def checking_log_of_dim_intf(package,host,portno,userid,pwd):
 print(package)
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 print(path)
 try:
     engine=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.tpi.log') and package in f.filename:
             a=f.filename
             break
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('_tp_installer.log') and package in f.filename:
             b=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     # print(f"<{keyword}> found in line {i+1} of engine log file")
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     with sftp_obj.open(b) as f1:
         f1.prefetch()
         buffer1 = f1.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     tp_installer=1
     if tp_installer==0:
         print(f'No issues found in file {b} under path-> {path}')
     if tp_installer==1:
         print(f'Some issues found in file {b} under path-> {path}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e) 
     return 'fail'  
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '

def checking_tp_activation(package,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 path1=f'/eniq/log/sw_log/engine/{package}-eniq_oss_1'
 print(path)
 try:
     engine=0
     tp_installer=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_activate_'+package+'_eniq_oss_1.log'):
             a=f.filename
             break 
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     sftp_obj.chdir(path1)
     engine_pkg_log=0
     print('reached -> ' +path1)
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('.log'):
             c=f.filename
             break
     with sftp_obj.open(c) as f2:
         f2.prefetch()
         buffer1 = f2.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine_pkg_log=1
     if engine_pkg_log==0:
         print(f'No issues found in file {c} under path-> {path1}')
     if engine_pkg_log==1:
         print(f'Some issues found in file {c} under path-> {path1}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e) 
     return "fail"  
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return " "

def checking_tp_installer_log(pkg,package,host,portno,userid,pwd):
 print(package)
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/tp_installer/'
 path1=f'/eniq/log/sw_log/engine/{pkg}'
 print(path)
 try:
     engine=0
     tp_installer=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith(package+'.log'):
             a=f.filename
             break
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('_tp_installer.log'):
             b=f.filename
             break
     
     print(b)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
     with sftp_obj.open(b) as f1:
         f1.prefetch()
         buffer1 = f1.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer1):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     tp_installer=1
     if tp_installer==0:
         print(f'No issues found in file {b} under path-> {path1}')
     if tp_installer==1:
         print(f'Some issues found in file {b} under path-> {path1}')
         return 'fail'
     sftp_obj.chdir(path1)
     engine_pkg_log=0
     print('reached -> ' +path1)
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         if f.filename.endswith('.log'):
             c=f.filename
             break
     with sftp_obj.open(c) as f2:
         f2.prefetch()
         buffer2 = f2.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer2):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     engine_pkg_log=1
     if engine_pkg_log==0:
         print(f'No issues found in file {c} under path-> {path1}')
     if engine_pkg_log==1:
         print(f'Some issues found in file {c} under path-> {path1}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e) 
     return 'fail'  
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return " "



def filter_date(strtmp):
  print(strtmp)
  strarr=strtmp.split('\r\n')
  str1=strarr[0].strip()
  print(str1)
  mntharray=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
  for i in range (0,11):
      if mntharray[i] in str1 and i<9:
         z=i+1
         break;
  datetimearr=str1.split(" ")
  temparr=[i for i in datetimearr if i.strip()]
  print(temparr)
  y = datetime(int(temparr[2]),z, int(temparr[1]),int(temparr[3].split(":")[0]),int(temparr[3].split(":")[1]),int(temparr[3].split(":")[2].split(".")[0]))
  return str(y)

def getmodifiedtime(package,tablename,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 linetmp=''
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/engine/{package}'
 print(path)
 try:
     keywords=[package+'.Topology.TopologyLoader_'+tablename+'.1.UnPartitionedLoader : Found 1 files']
     print(keywords)
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.log'):
             a=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 if re.search(keyword, line, re.IGNORECASE): 
                     print(f'{keyword} found in->',line)
                     linetmp=line
                     break
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 try:
  output=str(linetmp.split(" ")[1].split(":")[0]+":"+linetmp.split(" ")[1].split(":")[1])
  return output
 except Exception as e:
   print("Error is -> ",e)
 return " "

def update_automation_file(scriptname,date,tpname,modeltname,server,port,user,password):
  ssh_client = paramiko.SSHClient()
  port = 2251
  ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy()) 
  ssh_client.connect(server,port,user,password)
  ssh_file=ssh_client.open_sftp()
  if scriptname=='KeyCounter_Loading_Check.zip':
    path=f'/eniq/home/dcuser/Loading/input.properties'
    print('Connection established successfully')
    datem = datetime.strptime(date, "%d-%m-%Y-%H:%M")
    print(datem.day)        # 25
    print(datem.month)      # 5
    print(datem.year)       # 2021
    print(datem.hour)
    print(datem.minute)
    with ssh_file.open(path,'r') as f:
       con=f.readlines()
    print(con)
    with ssh_file.open(path,'w') as f:
     for l in con:
       if 'Date_id' in l:
            if datem.day<=9:
               b=re.sub('07','0'+str(datem.day),l)
            else:
               b=re.sub('07',str(datem.day),l)
            f.write(b)
            print(b)
       elif 'Month_id' in l:
            if datem.month<=9:
               b=re.sub('02','0'+str(datem.month),l)
            else:
               b=re.sub('02',str(datem.month),l)
            f.write(b)
            print(b)
       elif 'Hour_id' in l:
            if datem.hour<=9:
               b=re.sub('07','0'+str(datem.hour-1),l)
            else:
               b=re.sub('07',str(datem.hour-1),l)
            f.write(b)
            print(b)
       elif 'Min_id' in l:
            if datem.minute<=9:
               b=re.sub('09','0'+str(datem.minute),l)
            else:
               b=re.sub('09',str(datem.minute),l)
            f.write(b)
            print(b)
       elif 'Model-T_Name' in l:
            b=re.sub('DC_E_SCEF_3_R1A.xlsx',str(modeltname),l)
            f.write(b)
            print(b)
       else:
           f.write(l)
  elif scriptname=='DAY_Aggregation_Validator.zip':
    path=f'/eniq/home/dcuser/dayaggregation/automation.properties'
    print('Connection established successfully')
    datem = datetime.strptime(date, "%d-%m-%Y-%H:%M")
    print(datem.day)        # 25
    print(datem.month)      # 5
    print(datem.year)       # 2021
    with ssh_file.open(path,'r') as f:
       con=f.readlines()
    print(con)
    with ssh_file.open(path,'w') as f:
     for l in con:
       if 'Day_id' in l:
           b=re.sub('07',str(datem.day),l)
           f.write(b)
           print(b)
       elif 'Month_id' in l:
            b=re.sub('02',str(datem.month),l)
            f.write(b)
            print(b)
       elif 'Year_id' in l:
            b=re.sub('2020',str(datem.year),l)
            f.write(b)
            print(b)
       elif 'Model-T_Name' in l:
            b=re.sub('DC_E_SCEF_3_R1A.xlsx',str(modeltname),l)
            f.write(b)
            print(b)
       elif 'Techpack_Name' in l:
            b=re.sub('DC_E_SCEF_%_RAW',str(tpname),l)
            f.write(b)
            print(b)
       else:
           f.write(l)



def collectionid(output:str):
  try:
    z=' ----------------------------------------- '
    a=output.split('\r\n')
    print(a)
    return a[a.index(z)+1].strip()
  except Exception as e:
   print("Error is -> ",e)
  
  return " "

def getIndir(output:str):
  try:
    a=output.splitlines()
    for i in a:
      if 'inDir' in i:
        b=i.split("/")
        c=list(filter(None, b))
        return c[-1]
  except Exception as e:
    print("error is -> ",e)
  
  return " "

def editing_datetime_in_epfg_for_nr(output:str):
    x=output.split(" ")
    date=x[1]+" "+x[2]+" "+x[5]+" "+x[3]
    print(date)
    cur_time=datetime.strptime(date,"%b %d %Y %H:%M:%S")
    print(cur_time)
    final_time = cur_time + datetime.timedelta(minutes=2)
    print(final_time)
    final_time=datetime.strftime(final_time,"%d-%m-%Y-%H:%M")      
    print(final_time)
    return final_time


def filter_err_count(str):
  strarr=str.split('\r\n')
  try:
      return strarr[1].strip()
  except Exception as e:
    print("Exception is -> "+ e)

def makestr(temp):
  print(temp.split('\n'))
  s=''
  if(len(temp.split('\n'))>9):
    for i in range(9,len(temp.split('\n'))):
      #arr.append(temp.split('\n')[i])
      s=s+temp.split('\n')[i]+'\n'
    return s
  else:
    return 'true'
  return ""


def removestr(temp):
    print(temp)
    arr=[*temp]
    s=''
    for i in range(0,len(arr)-1):
      s+=arr[i]
    return s


def filterlength(s):
    print(s.split('\r\n'))
    return s.split('\r\n')[-2].strip()

def edit_epfg_for_multiple_oss(server,port,user,password):
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
        if l.startswith('ENIQ_VOLUME_MT_POINT='):
            x=re.sub('/eniq/data/pmdata/eniq_oss_1/','/eniq/data/pmdata/eniq_oss_1/;/eniq/data/pmdata/eniq_oss_2/',l)
            w.write(x)
            print(x)
        else:
            w.write(l)


def list_of_nodename(output):
    temp=output.split('\r\n')
    arr=[]
    for i in range(0,len(temp)):
      if temp[i].strip().startswith('('):
        break
      else:
        arr.append(temp[i].strip())
    arr.pop()
    print(arr)
    return arr

  
def test(output:str):
  return output.split('\r\n')[2].strip()

def processed_directory(output:str):
  arr=output.split('\r\n')
  for i in arr:
    if i.startswith("ProcessedFiles.fileNameFormat"):
      return i.split("=")[1]
  print(arr)

def system_status(s:str):
  dictr={}
  arr=s.split('\n')
  for i in arr:
      i=i.split()
      dictr.update({i[0]:i[1]})
  statusDictr=['eniq-connectd.service','eniq-dwhdb.service', 'eniq-engine.service', 'eniq-esm.service','eniq-licmgr.service', 'eniq-lwphelper.service', 'eniq-repdb.service', 'eniq-rmiregistry.service','eniq-scheduler.service', 'eniq-webserver.service']
  otherStatus=[]
  #print(dictr['eniq-connectd.service'])
  for key in statusDictr:
      if dictr[key]=='inactive':
          serviceName=key.split(".")[0]
          otherStatus.append(serviceName)
  return otherStatus

def getting_engine_profile(s:str):
  arr=s.split('\n')
  print(arr)
  for i in arr:
      if 'Current Profile:' in i:
        return i.strip()
  return ""

def give_build_number(s:str):
  if s.startswith('(('):
    return s.split("((")[1].split("))")[0]
  return s.split(":")[1].split("((")[1].split("))")[0]

def loading_topo_check(package,host,portno,userid,pwd):
 ssh_client = paramiko.SSHClient()
 server = host
 port = portno
 user = userid
 password = pwd
 ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
 path=f'/eniq/log/sw_log/engine/{package}'
 print(path)
 try:
     engine=0
     keywords=[' SEVERE ',' EXCEPTION ',' ERROR ',' FAILED ',' SKIP ',' WARNING ']
     ssh_client.connect(server,port,user,password)
     print('connected')
     sftp_obj=ssh_client.open_sftp()
     sftp_obj.chdir(path)
     print('reached path')
     for f in sorted(sftp_obj.listdir_attr(), key=lambda k: k.st_mtime, reverse=True):
         print(f.filename)
         if f.filename.endswith('.log'):
             a=f.filename
             break
     print(a)
     with sftp_obj.open(a) as f:
         f.prefetch()
         buffer = f.readlines()
         for keyword in keywords:
             for i, line in enumerate(buffer):
                 
                 if re.search(keyword, line, re.IGNORECASE):
                     
                     print(f'{keyword} found in->',line)
                     # print(f"<{keyword}> found in line {i+1} of engine log file")
                     engine=1
     if engine==0:
         print(f'No issues found in file {a} under path-> {path}')
     if engine==1:
         print(f'Some issues found in file {a} under path-> {path}')
         return 'fail'
 except paramiko.ssh_exception.AuthenticationException:
     print("Error establishing Connection with the server, Check the Server name, Port, User and Password")
 except Exception as e:
     print("Error is= ",e)   
 else:
     sftp_obj.close()
     ssh_client.close()
     print('Connection Closed')
 return ' '

def services_list(output1:str):
  output='''SERVICE               STATE       SUBSTATE    ENABLED     START TIME
  eniq-scheduler        inactive      running     enabled     Wed 2022-11-09 06:07:22 GMT
  eniq-engine           active      running     enabled     Fri 2022-11-18 10:58:47 GMT
  eniq-lwphelper        active      running     enabled     Wed 2022-11-09 06:08:07 GMT
  eniq-webserver        active      running     enabled     Wed 2022-11-09 07:22:32 GMT
  eniq-dwhdb            active      running     enabled     Wed 2022-11-09 06:08:59 GMT
  eniq-repdb            active      running     enabled     Wed 2022-11-09 06:07:19 GMT
  eniq-connectd         active      running     enabled     Wed 2022-11-09 06:07:11 GMT
  eniq-licmgr           active      running     enabled     Wed 2022-11-09 06:35:14 GMT
  eniq-rmiregistry      active      running     enabled     Wed 2022-11-09 06:07:12 GMT
  eniq-esm              active      running     enabled     Wed 2022-11-09 06:07:11 GMT
  eniqs[eniq_stats] {root} #:'''
  out_arr=[]
  arr=output1.split('\n')
  dictr={}
  c=0
  for i in arr:
    if(c!=0 and c<len(arr)-1):
      i=" ".join(i.split())
      i=i.split()
      dictr.update({i[0]:i[1]})
      c+=1
    elif c==0:
      c=1
  for key in dictr:
    if dictr[key]=='inactive':
      out_arr.append(key)
  return out_arr

def verify_area_file_data_loading(pkg,output):
  s=output
  ar=s.split('\n')
  c=0
  ar1=[]
  for i in ar:
    #print(i.strip())
    if(i.strip()==''):
      break
    ar1.append(i.strip())
  print(ar1)
  cmp_ar=[]
  if pkg=='DIM_E_UTRAN':
    s1='''AREA;AREA_GROUP;OSS_ID;CELL_ID;CELL_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;100;cell100;RNC
Lahti;Cell set;eniq_oss_1;10;cell10;RNC
Athlone;Cell Set;eniq_oss_1;199;Cell199;RNC
Athlone;Cell Set;eniq_oss_1;99;Cell99;RNC'''
    file_ar=s1.split('\n')
    file_ar.pop(0)
    for i in file_ar:
        for x in i.split(';'):
          cmp_ar.append(x)
    print(cmp_ar)
  if pkg=='DIM_E_GRAN':
    s1='''AREA,AREA_GROUP,OSS_ID,CELL_ID,CELL_NAME,NW_TYPE
Athlone,Cell Set,eniq_oss_1,AR12C00,AR12C00,AXE
Athlone,Cell Set,eniq_oss_1,AR12C01,AR12C01,AXE
Athlone,Cell Set,eniq_oss_1,AR12C02,AR12C02,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C03,AR12C03,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C04,AR12C04,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C05,AR12C05,AXE
Athlone,Athlone_group,eniq_oss_1,AR12C06,AR12C06,AXE'''
    file_ar=s1.split('\n')
    file_ar.pop(0)
    for i in file_ar:
        for x in i.split(','):
          cmp_ar.append(x)
    print(cmp_ar)
  if(ar1==cmp_ar):
    return 'true'
  return 'false'

def verify_area_file_for_lte_nr(pkg,out1,out2):
  s=out1
  st=out2
  ar=s.split('\n')
  arr=st.split('\n')
  c=0
  ar1=[]
  for i in ar:
      #print(i.strip())
      if(i==''):
          break
      ar1.append(i.strip())
  ar2=st.split('\n')
  c=0
  ar2=[]
  for i in arr:
      #print(i.strip())
      if(i==''):
          break
      ar2.append(i.strip())  
  print(ar1)
  print(ar2)

  s1='''AREA;AREA_GROUP;OSS_ID;CELL_ID;CELL_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;100;cell100;ERBS
Lahti;Cell set;eniq_oss_1;10;cell10;ERBS
Athlone;Cell Set;eniq_oss_1;199;Cell199;ERBS
Athlone;Cell Set;eniq_oss_1;99;Cell99;ERBS'''
  s2='''AREA;AREA_GROUP;OSS_ID;NRCELLCU_ID;NRCELLCU_NAME;NW_TYPE
Lahti;Cell set;eniq_oss_1;200;Cell200;NR
Lahti;Cell set;eniq_oss_1;20;Cell20;NR
Athlone;Cell Set;eniq_oss_1;15;cell15;NR
Athlone;Cell Set;eniq_oss_1;30;cell30;NR'''
  file_ar=s1.split('\n')
  file_ar1=s2.split('\n')
  cmp_ar=[]
  file_ar.pop(0)
  for i in file_ar:
      for x in i.split(';'):
          cmp_ar.append(x)
          file_ar=s1.split('\n')
  cmp_ar1=[]
  file_ar1.pop(0)
  for i in file_ar1:
      for x in i.split(';'):
          cmp_ar1.append(x)
  print(cmp_ar)
  print(cmp_ar1)
  if(cmp_ar==ar1 and cmp_ar1==ar2):
    return 'true'
  return 'false'

def BT_FT_validation_topo(out):
  ar=out.split('You have chosen 2,4')
  li=ar[1].split('\n')
  #print(li)
  r1=False
  r2=False
  for i in li:
      if 'Topology_Loading Check:PASS-' in i:
          if 'PASS- 0' not in i and 'FAIL- 0' in i:
              r1=True
      if 'ManMods_Check:PASS-' in i:
          if 'PASS- 0' not in i and 'FAIL- 0' in i:
              r2=True
  #print(r1,r2)
  return r1,r2

def get_table_list_topo(tables):
  tablelist=tables.split('\n')
  for i in range(0,len(tablelist)):
    tablelist[i]=tablelist[i].strip()
    
  tablelist.pop(-1)
  tablelist.pop(-1)
  tablelist.pop(-1)
  return tablelist

def verify_datetime_utctime(datetimedb,offsetdb,utcdatedb):
  datelist=datetimedb.split('\n')
  for i in range(0,len(datelist)):
    datelist[i]=datelist[i].strip()
  datelist.pop(-1)
  datelist.pop(-1)
  datelist.pop(-1)
  offsetlist=offsetdb.split('\n')
  for i in range(0,len(offsetlist)):
    offsetlist[i]=offsetlist[i].strip()
  offsetlist.pop(-1)
  offsetlist.pop(-1)
  offsetlist.pop(-1)
  utcdatelistdb=utcdatedb.split('\n')
  for i in range(0,len(utcdatelistdb)):
    utcdatelistdb[i]=utcdatelistdb[i].strip()
  utcdatelistdb.pop(-1)
  utcdatelistdb.pop(-1)
  utcdatelistdb.pop(-1)
  for i in range(0,len(utcdatelistdb)):
    datetime_object = datetime.strptime(utcdatelistdb[i], '%b %d %Y %H:%M:%S.000000AM')
    if offsetlist[i]=='+0200':
        utcdatelistdb[i]=datetime.strftime(datetime_object+datetime.timedelta(hours=2),'%b %d %Y %H:%M:%S.000000AM')
    if offsetlist[i]=='-0200':
        utcdatelistdb[i]=datetime.strftime(datetime_object-datetime.timedelta(hours=2),'%b %d %Y %H:%M:%S.000000AM')
  return utcdatelistdb==datelist
  
def validating_ossId(out):
  ossIdList=out.split('\n')
  for i in range(0,len(ossIdList)):
    ossIdList[i]=ossIdList[i].strip()
  ossIdList.pop(-1)
  ossIdList.pop(-1)
  ossIdList.pop(-1)
  print(ossIdList,len(ossIdList))
  for i in ossIdList:
    if i == 'eniq_oss_1' or i =='eniq_oss_2':
      continue
    else:
      return False
  return True 

#SHUBHAM CODE STARTS FROM HERE
def BT_FT_validation_For_Aggregation(s):
    flag=True
    li=s.split('\n')
    mainli=[]
    for i in li:
        if  'PASS-' in i and 'FAIL- ' in i :
            mainli.append(i)
    for i in mainli:
        if not 'FAIL- 0' in i:
            flag=False
        if 'PASS- 0 FAIL- 0' in i:  
            flag=False 
    return flag

def topo_val_not_in_list(a:list,b:list):
    pm=set(a)
    topo=set(b)
    c=pm==topo
    if not c:
        return False, topo.difference(pm)
    else:
        return True, 'All Values are Present'      

def Count_Delta_val_not_in_list(a:list,b:list):
    count=set(a)
    delta=set(b)
    c=count==delta
    if not c:
        return False, count.difference(delta)
    else:
        return True, 'All Values are Present'    
####Shubham Code End########
######Bharathi code starts


def ffaxw(ffaxw, pmbranchdelta):

   y = pmbranchdelta.split('\r\n')
   del y[-2:]
   pmbranchdelta_list = [int(i) for i in y if i.strip()]
   lis = []
   file = open('H:\\ENIQ_TC_Automation\TP\Bharathi\FFAXW.txt', 'r')
   for line in file.readlines():
      fname = line.rstrip().split(' ')
      for i in fname:
         if (i.startswith('VALUES')):
            status = i.split(',')[-1]
            lis.append(status.replace(')', ''))

   test_list = [float(i) for i in lis]
   midpoint = test_list
   multiply_midpoint = np.multiply(pmbranchdelta_list, midpoint)
   totalpmbranchdelta = np.sum(pmbranchdelta_list)
   totalmultiplymid = np.sum(multiply_midpoint)
   mean = totalmultiplymid/totalpmbranchdelta
   midpoint_mean_sub = [x-mean for x in midpoint]
   midpoint_mean = np.multiply(midpoint_mean_sub, midpoint_mean_sub)
   midpoint_mean = [np.double(x) for x in midpoint_mean]
   frequency_pmbranchdelta = np.multiply(pmbranchdelta_list, midpoint_mean)
   frequency_pmbranchdelta = [np.double(x) for x in frequency_pmbranchdelta]
   total_frequency_pmbranchdelta = np.sum(frequency_pmbranchdelta)
   standard_deviation = np.sqrt(
       total_frequency_pmbranchdelta/totalpmbranchdelta)
   standard_deviation = np.round(standard_deviation, 2)
   power = np.power(standard_deviation, 2)
   pmBranchDeltaSir_Samples_SD_SD = np.multiply((totalpmbranchdelta-1), power)
   pmBranchDeltaSir_Samples_SD_SD = np.round(pmBranchDeltaSir_Samples_SD_SD, 2)
   print("pmBranchDeltaSir_Samples_SD_SD", pmBranchDeltaSir_Samples_SD_SD)
   mean = np.round(mean, 2)
   pmBranchDeltaSir_Samples_MEAN = np.multiply(totalpmbranchdelta, mean)
   pmBranchDeltaSir_Samples_MEAN = np.round(pmBranchDeltaSir_Samples_MEAN, 2)
   print("pmBranchDeltaSir_Samples_MEAN", pmBranchDeltaSir_Samples_MEAN)
   power_mean = np.power(mean, 2)
   pmBranchDeltaSir_Samples_MEAN_MEAN = np.multiply(
       totalpmbranchdelta, power_mean)
   pmBranchDeltaSir_Samples_MEAN_MEAN = np.round(
       pmBranchDeltaSir_Samples_MEAN_MEAN, 2)
   print("pmBranchDeltaSir_Samples_MEAN_MEAN",
         pmBranchDeltaSir_Samples_MEAN_MEAN)
   file.close()
   return pmBranchDeltaSir_Samples_SD_SD, pmBranchDeltaSir_Samples_MEAN, pmBranchDeltaSir_Samples_MEAN_MEAN


def ffaxw_date(output):
   z = "".join(output.split("\n")[:-2])
   d_db = z.strip()
   return d_db


def ffaxw_comapare(db_out, rbs_out):
   a, b, c = float(db_out[0]), float(db_out[1]), float(db_out[2])
   d, e, f = rbs_out[0], rbs_out[1], rbs_out[2]

   print(a, b, c)
   print(d, e, f)
   if a == d and b == e and c == f:
      return True
   else:
      return False


def compare_utran(a_db, b_xml):
    print(a_db, b_xml)
    z = "".join(a_db.split("\n")[:-2])
    d_db = z.strip()
    flag = False
    if b_xml == d_db:
        flag = True
        return flag
    else:
       flag = False
       return flag


def compare1_utran(b1):
    b1_xml = str(b1.replace("[", ""))
    b1_xml = str(b1_xml.replace("]", ""))
    b1_xml = str(b1_xml.replace(' ', ''))
    print(b1_xml)
    res = list(map(lambda x: str(x), b1_xml.split(',')))
    index = 0
    Flag = False
    for i in res:
        if (i.startswith('MeContext')):
            index = res.index(i)
            print(index, i)
            Mecontext = res.__getitem__(index)
            context = Mecontext.split('=')[-1]
            inde = index-1
            sub = res.__getitem__(inde)
            status = sub.split('=')[-1]
            x = status.startswith("ONRM")
            y = status.startswith("SubNetwork")
            if x == False and y == False:
                Flag = True
                return context, status, Flag
            else:
                if x == True or y == True:
                  Flag = False
                  return context, status, Flag


def compare2_utran(a_db, b_xml, flag):
    z = "".join(a_db.split("\n")[:-2])
    d_db = z.strip()
    if " " in z and flag == False:
      return "EMPTY"
    elif d_db == b_xml and flag == True:
       return True
    else:
       return False


def nr_plmn(a, b):
    y = str(a)
    c_xml = sum(b, [])
    z = "".join(y.split("\n")[1:][:-2])
    d = z.strip()
    d = d.replace('    ', ' ')
    b_db = list(map(lambda x: int(x), d.split()))
    c_xml = [int(x) for x in c_xml]
    for i in b_db:
        if i in c_xml:
            return True
        else:
            return False


def netop_index(input_mecontext):

   Mecontext = 0
   Managed = 0
   for i in input_mecontext:

      if (i.startswith('MeContext')):
         Mecontext = input_mecontext.index(i)

      if (i.startswith('Managed')):
         Managed = input_mecontext.index(i)

   return Mecontext, Managed


####Bharathi Code End########

######Ashwini code starts
def values(outputone):
    z = "".join(outputone.split("\n")[:-2])
    d_db = z.strip()
    return d_db

def valueone(outputone):
    a = float(outputone)
    b = int(a)
    return b

def valuetwo(outputone):
        z="".join(outputone.split("\n")[:-2])        
        d_db=z.strip()
        b= int(d_db)
        return  b

def  valuethree(outputone):
        z="".join(outputone.split("\n")[:-2])        
        return z

def compareone(str1, str2):
    a = len(str1)
    b = len(str2)
    result = True
    if a <= b:
        for i in range(0, a):
            if (str1[i] != str2[i]):
                result = False
                break
            return result

def Aggregation(output):
    flag = True
    valueone = output.replace(' ', "")
    valuetwo = valueone.replace('\r\n', "")
    valuethree = re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)", '', valuetwo)
    valuefour = re.findall("DC\S*\s*\S*\s*DAY", valuethree)
    lst_not_loaded = [re.sub('\t', ' ', i) for i in valuefour if 'NOT_LOADED' in i]
    lst_aggregated = [re.sub('\t', ' ', i) for i in valuefour if 'AGGREGATED' in i]
    lst_failed = [re.sub('\t', ' ', i) for i in valuefour if 'FAILEDDEPENDENCY' in i]
    lst_blocked = [re.sub('\t', ' ', i) for i in valuefour if 'BLOCKED' in i]
    if lst_aggregated:
        if lst_failed and not lst_not_loaded and not lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed \n{lst_failed} \n List of Blocked tables \n {lst_blocked} List of Aggregated Tables\n {lst_aggregated}'
        if not lst_failed and lst_blocked and lst_not_loaded:
            flag = False
            return flag, f'{len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded} \n List of Aggregated Tables \n {lst_aggregated}' 
        if not lst_failed and not lst_not_loaded and not lst_blocked:
            return flag, f'All {len(lst_aggregated)} tables are Aggregated'
        if lst_failed and lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_blocked)} tables are blocked \n List of Blocked tables \n {lst_blocked} \n List of  tables are failed \n{lst_failed} \n tables are not loaded\n{lst_not_loaded} \n  List of Aggregated Tables\n {lst_aggregated}'
        if not lst_failed and not lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_blocked)} tables are blocked \n{lst_blocked}'
        if lst_failed and not lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed\n{lst_failed} \n List of Aggregated Tables \n {lst_aggregated} \n List of Blocked tables \n {lst_blocked}' 
        if lst_failed and lst_not_loaded and not lst_blocked:
            flag = False
            return flag, f'{len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded} \n List of Aggregated Tables \n {lst_aggregated} \n List of  tables are failed \n{lst_failed}'
        if not lst_failed and lst_not_loaded and not lst_blocked:
            flag = False
            return flag, f'{len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded} \n List of Aggregated Tables \n {lst_aggregated}'
    else:
        if lst_failed and not lst_not_loaded and not lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed\n{lst_failed}'
        if not lst_failed and lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded} \n {len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded}'
        if  lst_failed and lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed\n{lst_failed} \n {len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded} \n {len(lst_blocked)} tables are blocked\n{lst_blocked}'
        if lst_failed and lst_not_loaded and not lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed\n{lst_failed} \n {len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded}'
        if lst_failed and not lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_failed)} tables are failed\n{lst_failed} \n {len(lst_blocked)} tables are blocked\n{lst_blocked}'
        if not lst_failed and not lst_not_loaded and lst_blocked:
            flag = False
            return flag, f'{len(lst_blocked)} tables are blocked\n{lst_blocked}'
        if not lst_failed and not lst_blocked and lst_not_loaded:
            flag = False
            return flag, f'{len(lst_not_loaded)} tables are not loaded\n{lst_not_loaded}' 


def solve(s):
   ret = '_RANKBH  '.join(s)
   return ret
def combining_bhobject_and_bhtype(list1,list2):      
        for i,j in  zip(list1,list2):
                a = i+'_'+j        
                "".join(a)        
        return a
def values2(outputone):

    z = "".join(outputone.split("\n")[:-1])
    d_db = z.split()
    return d_db

def abc(list1,list2):
        
        b= []
        for i,j in  zip(list1,list2):
                a = i+'_'+j
                b.append(a)
        return b,len(b)

def stringcomaprison(output1, output2):
        print(output1.find(output2))
        if(output1.find(output2) == -1):
                print("not found")
        else:
                print("string found")

def matchstring(output):
    b = output.split("_")
    if (output.find(b[5]) == -1):
        print("string not found")
    else:
        print("string found")
    return b[5]

def     list_of_aggregated_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_aggregated=[re.sub('\t',' ',i) for i in valuefour if 'AGGREGATED' in i]
    return(lst_aggregated)
def     aggregated_tables(output):
    str= " "
    return(str.join(output))
def     list_of_failed_dependency_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_failed= [re.sub('\t',' ',i) for i in valuefour if 'FAILEDDEPENDENCY' in i]
    # return(str.join(lst_failed))
    return(lst_failed)
def     failed_tables_str_conversion(output):
    str = " "
    return(str.join(output))
def     list_of_not_loaded_tables(output):
    # flag=True
    # failed_tables=[]
    # not_loaded=[]
    valueone = output.replace(' ',"")
    valuetwo= valueone.replace('\r\n',"")
    valuethree= re.sub(r"(eniq\S*\s*\S*\s*\S*\s*\S*-b)",'',valuetwo)
    valuefour= re.findall("DC\S*\s*\S*\s*DAY",valuethree)
    lst_not_loaded=[re.sub('\t',' ',i) for i in valuefour if 'NOT_LOADED' in i]
    return(lst_not_loaded)
def     not_loaded_tables(output):
    str= " "
    return(str.join(output))
#######Ashwini code ends
