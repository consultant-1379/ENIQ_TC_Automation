import os
import subprocess
import filecmp
import commands as c

def check_ip_config(string):

    '''Check wheather IP address is congigured or not'''
    
    if len(string) !=0 :
        if string[0].isalpha():
            return "Warning:Ethernet is assigned to server but ip address is not configured"
        elif string[0].isdigit():
            return '\n*********IP address is configured!*********\n'
    else:
        return "\nIP address is not configured!\n"


def ensure_password_policies_rollback(path):
    ''' Ensure Password policy '''
    try:
        with open(path, 'r') as file_confg:
            data = file_confg.read()
        if 'minlen = 9' in data and 'dcredit = 1' in data and 'ucredit = 1' in data \
            and 'ocredit = 1' in data and 'lcredit = 1' in data:
            return True
        else:
            return False
    except IOError :
        return  "Something went wrong"
        
        
def get_custom_file_cmp(banner_ssh_path, issue_path):
    file_size = subprocess.check_output("ls -lrth /etc/issue | cut -d' ' -f 5", shell=True)
    file_cmp_out = filecmp.cmp(banner_ssh_path, issue_path)
    if file_size == '26\n':
        os.system("cp /ericsson/security/bin/banner_ssh /etc/issue")
        return 'SSH LOGIN BANNER is successfully configured in /etc/issue!'
    elif file_cmp_out:
        return 'SSH LOGIN BANNER is already configured in /etc/issue!'
    else:
        return "Customized banner message found in /etc/issue!"
        
def file_cmp(banner_motd_path, motd_path):
    file_cmp_out = filecmp.cmp(banner_motd_path, motd_path)
    if file_cmp_out !=0:
        print "Banner is already present"
        return  file_cmp_out
    else:
        print "need to configure"
        return  file_cmp_out
        


def check_disable_access_suid():
    allowed = ["/usr/lib/polkit-1/polkit-agent-helper-1", "/usr/sbin/usernetctl",
         "/usr/sbin/pam_timestamp_check", "/usr/sbin/mount.nfs",
         "/usr/sbin/userhelper", "/usr/sbin/unix_chkpwd", "/usr/bin/chsh",
         "/usr/bin/chfn", "/usr/bin/crontab", "/usr/bin/gpasswd",
         "/usr/bin/sudo", "/usr/bin/chage", "/usr/bin/pkexec", "/usr/bin/su",
         "/usr/bin/newgrp", "/usr/libexec/dbus-1/dbus-daemon-launch-helper",
         "/usr/bin/passwd", "/usr/bin/mount", "/usr/bin/umount", "/usr/bin/staprun"
        ]
    allsuid = c.getoutput("find / -perm -4000 2> /dev/null").split('\n')
    for suid in allsuid:
        if suid not in allowed:
            return "FAIL"
    return "SUCCESS"


def check_age_or_warning():
    eniq_insttype_path = os.path.exists("/eniq/installation/config/")
    age = ['30', '60', '90', '99999']
    war = ['7','15']
    a, w = c.getoutput("chage -l root | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2").split()
    if a in age or w in war:
        print "AGE or WARNING SET for MWS"
        return "Sucess"

    elif eniq_insttype_path is True:
        users = ['root', 'dcuser']
        age = ['30', '60', '90', '99999']
        war = ['7','15']
        for user in users:
            a, w = c.getoutput("chage -l "+user+" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2").split()
            if a in age or w in war:
                print "AGE or WARNING NOT SET for ENIQ"
                return "Sucess"

    else:
        print "server not properly configured"
    return "FAIL"
    

def checking_MWS_configured_or_not(mws_path, mount_point, eniq_path):
    mws_insttype_path = os.path.exists(mws_path)
    check_mount_point = os.path.ismount(mount_point)
    eniq_insttype_path = os.path.exists(eniq_path)
    
    if mws_insttype_path is True:
        mws_insttype = c.getoutput("cat /ericsson/config/inst_type")
        server_config_name = c.getoutput("cat /ericsson/config/ericsson_use_config | cut -d'=' -f 2")
    if (check_mount_point != True) or ('rhelonly' not in mws_insttype) or ('mws' not  in server_config_name):
        return "FAIL"
    else:
        return "SUCCESS"

#obj = checking_MWS_configured_or_not("/ericsson/config/inst_type", "/JUMP", "/eniq/installation/config/")
#print("LLLLLLL", obj)

def check_password_age():
    users = open("/etc/passwd",'r').readlines()
    for user in users:
        data1 = user.split(':')
        if (data1[0] != "dcuser") and (data1[0] != "root") and (data1[0] != "storadm") and (int(data1[2]) > 999):
            a = c.getoutput("chage -l "+data1[0]+" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2")
            if '60' not in a:
                return "FAIL"
        if data1[0] == "storadm":
            a = c.getoutput("chage -l "+data1[0]+" | tail -n 2 | cut -d':' -f2 | cut -d' ' -f2")
            if '60' in a :
                return "FAIL"
    return "SUCCESS"
    
    
def verify_static_ip_config():
    with open('/ericsson/security/log/system_config.log', 'r') as fin:
        data1 = fin.readlines()
    a = "/etc/sysconfig/network-scripts/ifcfg-"
    for i in data1:
        i = i.replace('\n', '')
        k = a+i
        file_check = os.path.exists(k)
        if file_check == True:
            cmd = "cat %s"%(k)
            result = subprocess.check_output(cmd, shell=True)
            if "BOOTPROTO=dhcp" not in result:
                print "not FOUND"
            else:
              return 'FAIL'
    return 'SUCCESS'
    
          
          

