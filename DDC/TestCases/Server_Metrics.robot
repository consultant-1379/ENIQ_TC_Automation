*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            Collections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Library            RPA.FileSystem
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for eniq_history file in source TC01
    [Documentation]       Checking for eniq_history file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/admin/version/eniq_history

Checking for eniq_history file size in source TC02
    Depends on test       Checking for eniq_history file in source TC01
    [Documentation]       Checking for non empty eniq_history file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/admin/version/eniq_history

Checking for eniq_history file in destination TC03
    Depends on test       Checking for eniq_history file size in source TC02
    [Documentation]       Checking for eniq_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_history

Checking for eniq_history file size in destination TC04
    Depends on test       Checking for eniq_history file in destination TC03
    [Documentation]       Checking for non empty eniq_history file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_history

Checking for eniq_status file in source TC05
    [Documentation]       Checking for eniq_status file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/admin/version/eniq_status

Checking for eniq_status file size in source TC06
    Depends on test       Checking for eniq_status file in source TC05
    [Documentation]       Checking for non empty eniq_status file in /eniq/admin/version directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/admin/version/eniq_status

Checking for eniq_status file in destination TC07
    Depends on test       Checking for eniq_status file size in source TC06
    [Documentation]       Checking for eniq_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_status

Checking for eniq_status file size in destination TC08
    Depends on test       Checking for eniq_status file in destination TC07
    [Documentation]       Checking for non empty eniq_status file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                Server_Metrics
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/eniq_status

# Checking for btmp file in server directory
#     [Documentation]       Checking for btmp file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/btmp
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/btmp

# Checking for boot.log file in server directory
#     [Documentation]       Checking for boot.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/boot.log
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/boot.log

# Checking for cpuinfo file in server directory
#     [Documentation]       Checking for cpuinfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/cpuinfo
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/cpuinfo

Checking for cron.log file in server directory TC09
    [Documentation]       Checking for cron.logfile and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/cron.log
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/cron.log

# Checking for ddc.log file in server directory
#     [Documentation]       Checking for ddc.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ddc.log
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ddc.log

Checking for df.txt file in server directory TC10
    [Documentation]       Checking for df.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/df.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/df.txt

Checking for dmidecode.txt file in server directory TC11
    [Documentation]       Checking for dmidecode.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/dmidecode.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/dmidecode.txt

Checking for dmsetup.txt file in server directory TC12
    [Documentation]       Checking for dmsetup.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/dmsetup.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/dmsetup.txt

Checking for ERICddccore.rpminfo file in server directory TC13
    [Documentation]       Checking for ERICddccore.rpminfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ERICddccore.rpminfo
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ERICddccore.rpminfo

Checking for hostname file in server directory TC14
    [Documentation]       Checking for hostname file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/hostname
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/hostname

Checking for ifconfig.txt file in server directory TC15
    [Documentation]       Checking for ifconfig.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ifconfig.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ifconfig.txt

Checking for iptables.txt file in server directory TC16
    [Documentation]       Checking for iptables.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/iptables.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/iptables.txt

Checking for jps.log file in server directory TC17
    [Documentation]       Checking for jps.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/jps.log
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/jps.log

Checking for lastlog file in server directory TC18
    [Documentation]       Checking for lastlog file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/lastlog
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/lastlog

Checking for last.txt file in server directory TC19
    [Documentation]       Checking for last.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    ${last_server_reboot}=     Run Keyword And Return Status    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/last.txt
    Set Global Variable    ${last_server_reboot}
    Log To Console    ${last_server_reboot}
    IF    ${last_server_reboot} == True
    ${last_server_reboot_size}=     Run Keyword And Return Status     Check File Size New     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/last.txt
    Set Global Variable    ${last_server_reboot_size}
    Run Keyword If   ${last_server_reboot_size} == True   Pass Execution    File size is not zero   ELSE   Skip    Size is zero
    ELSE
        Skip   last.txt log and size is not there in the expected path
    END

# Checking for lvs.txt file in server directory
#     [Documentation]       Checking for lvs.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/lvs.txt
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/lvs.txt

Checking for meminfo file in server directory TC20
    [Documentation]       Checking for meminfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/meminfo
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/meminfo

Checking for messages file in server directory TC21
    [Documentation]       Checking for messages file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/messages
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/messages

Checking for multipath.txt file in server directory TC22
    [Documentation]       Checking for multipath.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/multipath.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/multipath.txt

# Checking for netstat_an.log file in server directory
#     [Documentation]       Checking for netstat_an.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/netstat_an.log
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/netstat_an.log

Checking for netstat_i.log file in server directory TC23
    [Documentation]       Checking for netstat_i.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/netstat_i.log
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/netstat_i.log

# Checking for nfsstat_m.txt file in server directory
#     [Documentation]       Checking for nfsstat_m.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/nfsstat_m.txt
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/nfsstat_m.txt

Checking for nfsstat.txt file in server directory TC24
    [Documentation]       Checking for nfsstat.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/nfsstat.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/nfsstat.txt

Checking for pagesize file in server directory TC25
    [Documentation]       Checking for pagesize file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/pagesize
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/pagesize

Checking for partitions file in server directory TC26
    [Documentation]       Checking for partitions file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/partitions
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/partitions

Checking for pvs.txt file in server directory TC27
    [Documentation]       Checking for pvs.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/pvs.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/pvs.txt

# Checking for slabinfo file in server directory
#     [Documentation]       Checking for slabinfo file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/slabinfo
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/slabinfo

Checking for socket.log file in server directory TC28
    [Documentation]       Checking for socket.log file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/socket.log
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/socket.log

# Checking for ss.txt file in server directory
#     [Documentation]       Checking for ss.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ss.txt
#     Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/ss.txt

Checking for tz.txt file in server directory TC29
    [Documentation]       Checking for tz.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/tz.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/tz.txt

Checking for uptime.txt file in server directory TC30
    [Documentation]       Checking for uptime.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/uptime.txt
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/uptime.txt

# Checking for virtwhat.txt file in server directory
#     [Documentation]       Checking for virtwhat.txt file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
#     [Tags]                Server_Metrics
#     Check File Exists                     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/virtwhat.txt
#     Check File Size Does Not Exists       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/virtwhat.txt

Checking for sar.incr file in server directory TC31
    [Documentation]       Checking for sar.incr file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr

Checking for sar_incr file in server directory TC32
    [Documentation]       Checking for sar_incr file and its size in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                Server_Metrics
    ${sar_incr}=           Execute Command    cat /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr | cut -d "@" -f 1
    Set Global Variable    ${sar_incr}
    Check File Exists     /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.${sar_incr}
    Check File Size       /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.${sar_incr}

