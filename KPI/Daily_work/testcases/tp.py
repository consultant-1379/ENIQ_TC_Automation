import glob
import os
import re
import time
from datetime import datetime
from functools import wraps
import paramiko


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

def get_parser_value(output):
    return output.split('\n')[0].strip()

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


def lcmbiar_file_transfer_to_local(package, serv):
    ssh_client = paramiko.SSHClient()
    server = f'atvts{serv}.athtem.eei.ericsson.se'
    port = 2251
    user = 'dcuser'
    password = 'Dcuser%12'
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        ssh_client.connect(server, port, user, password)
        print('Connection established successfully')
        stdin, stdout, stderr=ssh_client.exec_command(f"find /eniq/sw/installer/boreports -name '*.lcmbiar' -print |grep -i '{package}'| tail -n 1")
        a=str(stdout.readline()).replace('\n','')
        if len(a)>0:
            remote_path = f"{a}"
            local_path = f"C:\\Users\\Administrator\\Downloads/{a.split('/')[-1]}"
            with ssh_client.open_sftp() as ssh_transfer:
                ssh_transfer.get(remote_path,local_path)
            checking_file=os.path.exists(f"C:\\Users\\Administrator\\Downloads/{a.split('/')[-1]}")
            if checking_file:
                print(f"File-> {a.split('/')[-1]} transferred to-> {local_path.split('/')[0]} Successfully")
                return  f"C:\\Users\\Administrator\\Downloads/{a.split('/')[-1]}"
            else:
                print('LCMBIAR file not present')
        else:
            print(f'No lcmbiar file found for {package}')
    except Exception as e:
        print("Error is= ", e)
    finally:
        ssh_client.close()
        print('All Connections are Closed')
# lcmbiar_file_transfer_to_local()
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
        keywords = ['SEVERE', 'EXCEPTION',
                    'ERROR', 'FAILED', 'SKIP', 'WARNING']
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


def setting_to_finest(ax):
    host = 'atvts4051.athtem.eei.ericsson.se'
    port = 22
    uname = 'root'
    pwd = 'shroot'
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(host, port, uname, pwd)
    ssh_transfer = ssh_client.open_sftp()
    path = r'/root/sa/eng.properties'
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
