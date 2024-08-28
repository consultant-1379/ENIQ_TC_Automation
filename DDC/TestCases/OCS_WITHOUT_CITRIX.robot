*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking ocs_without_citrix ip file TC01
    [Documentation]                      Checking for ${ocs_without_citrix_ip_file} log file in /eniq/installation/config/windows_server_conf_files directory
    [Tags]                               OCS_WITHOUT_CITRIX
    ${ocs_without_citrix_ip_file}=       Execute Command    ls -lrt /eniq/installation/config/windows_server_conf_files | grep "OCS-WITHOUT-CITRIX" | tr -s ' ' | cut -d ' ' -f9
    Set Global Variable                  ${ocs_without_citrix_ip_file}
    Check File Exists                    /eniq/installation/config/windows_server_conf_files/${ocs_without_citrix_ip_file}

Checking ocs_without_citrix ip addr TC02
    Depends on test                      Checking ocs_without_citrix ip file TC01
    [Documentation]                      Check OCS_WITHOUT_CITRIX Ip addr
    [Tags]                               OCS_WITHOUT_CITRIX
    ${ocs_without_citrix_ip_addr}=       Execute Command   echo ${ocs_without_citrix_ip_file} | awk -F "-" '{print $4}'
    Set Global Variable                  ${ocs_without_citrix_ip_addr}

Checking ocs_without_citrix mounting path TC03
    Depends On Test           Checking ocs_without_citrix ip addr TC02
    [Documentation]           Check whether OCS_WITHOUT_CITRIX mount path is available or not
    [Tags]                    OCS_WITHOUT_CITRIX
    ${mounting_logs}=         Execute Command   mount -t nfs ${ocs_without_citrix_ip_addr}:/C:/OCS-without-Citrix/DDC_logs ${ocs_without_citrix_mount_path} -o ro,soft,vers=3,nosuid,nodev,nordirplus
    ${log_files}              Execute Command    cd ${ocs_without_citrix_mount_path} && ls
    Count Of Files            ${ocs_without_citrix_mount_path}
    Should Be Equal As Strings    ${count}    2

Checking ocs_without_citrix hostname file in source TC04
    [Documentation]           Checking for hostname.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Check File Exists         /eniq/OCS-WITHOUT-CITRIX/system_logs/hostname.tsv

Checking ocs_without_citrix hostname file size in source TC05
    Depends on test           Checking ocs_without_citrix hostname file in source TC04
    [Documentation]           Checking for non empty hostname.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Check File Size           /eniq/OCS-WITHOUT-CITRIX/system_logs/hostname.tsv

Checking ocs_without_citrix hostname file in destination TC06
    Depends on test           Checking ocs_without_citrix hostname file size in source TC05
    [Documentation]           Checking for hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/hostname.tsv

Checking ocs_without_citrix hostname file size in destination TC07
    Depends on test           Checking ocs_without_citrix hostname file in destination TC06
    [Documentation]           Checking for non empty hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/eniq/ocs_without_citrix_system/hostname.tsv

Checking for count of ocs_without_citrix system log files in source TC08
    [Documentation]           Checking for count of log files in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Count Of Files            /eniq/OCS-WITHOUT-CITRIX/system_logs/*_${yesterday_ymd}.tsv
    Should Be Equal As Strings    ${count}    17

Checking for count of ocs_without_citrix system log files in destination TC09
    Depends on test           Checking for count of ocs_without_citrix system log files in source TC08
    [Documentation]           Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                    OCS_WITHOUT_CITRIX
    Count Of Files            /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/*_${yesterday_ymd}.tsv
    Should Be Equal As Strings    ${count}    17

Checking for missing system ocs_without_citrix log files TC10
    [Documentation]       Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check Missing File    /eniq/OCS-WITHOUT-CITRIX/system_logs/*_${yesterday_ymd}.tsv    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/*_${yesterday_ymd}.tsv

Checking Drive_Info file in ocs_without_citrix source TC11
    [Documentation]       Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file size in ocs_without_citrix source TC12
    Depends on test       Checking Drive_Info file in ocs_without_citrix source TC11
    [Documentation]       Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file in ocs_without_citrix destination TC13
    Depends on test       Checking Drive_Info file size in ocs_without_citrix source TC12
    [Documentation]       Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file size in ocs_without_citrix destination TC14
    Depends on test       Checking Drive_Info file in ocs_without_citrix destination TC13
    [Documentation]       Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Drive_Info_${yesterday_ymd}.tsv

Checking Hardware_Details file in ocs_without_citrix source TC15
    [Documentation]       Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file size in ocs_without_citrix source TC16
    Depends on test       Checking Hardware_Details file in ocs_without_citrix source TC15
    [Documentation]       Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file in ocs_without_citrix destination TC17
    Depends on test       Checking Hardware_Details file size in ocs_without_citrix source TC16
    [Documentation]       Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file size in ocs_without_citrix destination TC18
    Depends on test       Checking Hardware_Details file in ocs_without_citrix destination TC17
    [Documentation]       Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Hardware_Details_${yesterday_ymd}.tsv

Checking Logical_Disk file in ocs_without_citrix source TC19
    [Documentation]       Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file size in ocs_without_citrix source TC20
    Depends on test       Checking Logical_Disk file in ocs_without_citrix source TC19
    [Documentation]       Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file in ocs_without_citrix destination TC21
    Depends on test       Checking Logical_Disk file size in ocs_without_citrix source TC20
    [Documentation]       Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file size in ocs_without_citrix destination TC22
    Depends on test       Checking Logical_Disk file in ocs_without_citrix destination TC21
    [Documentation]       Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Logical_Disk_${yesterday_ymd}.tsv

Checking Memory file in ocs_without_citrix source TC23
    [Documentation]       Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Memory_${yesterday_ymd}.tsv

Checking Memory file size in ocs_without_citrix source TC24
    Depends on test       Checking Memory file in ocs_without_citrix source TC23
    [Documentation]       Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Memory_${yesterday_ymd}.tsv

Checking Memory file in ocs_without_citrix destination TC25
    Depends on test       Checking Memory file size in ocs_without_citrix source TC24
    [Documentation]       Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Memory_${yesterday_ymd}.tsv

Checking Memory file size in ocs_without_citrix destination TC26
    Depends on test       Checking Memory file in ocs_without_citrix destination TC25
    [Documentation]       Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Memory_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in ocs_without_citrix source TC27
    [Documentation]       Checking for  Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file size in ocs_without_citrix source TC28
    Depends on test       Checking Memory_Related_Counters file in ocs_without_citrix source TC27
    [Documentation]       Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in ocs_without_citrix destination TC29
    Depends on test       Checking Memory_Related_Counters file size in ocs_without_citrix source TC28
    [Documentation]       Checking for Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file size in ocs_without_citrix destination TC30
    Depends on test       Checking Memory_Related_Counters file in ocs_without_citrix destination TC29
    [Documentation]       Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking NBT_Connections file in ocs_without_citrix source TC31
    [Documentation]       Checking for  NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file size in ocs_without_citrix source TC32
    Depends on test       Checking NBT_Connections file in ocs_without_citrix source TC31
    [Documentation]       Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file in ocs_without_citrix destination TC33
    Depends on test       Checking NBT_Connections file size in ocs_without_citrix source TC32
    [Documentation]       Checking for NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file size in ocs_without_citrix destination TC34
    Depends on test       Checking NBT_Connections file in ocs_without_citrix destination TC33
    [Documentation]       Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/NBT_Connections_${yesterday_ymd}.tsv

Checking Network_Interface file in ocs_without_citrix source TC35
    [Documentation]       Checking for  Network_Interface_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file size in ocs_without_citrix source TC36
    Depends on test       Checking Network_Interface file in ocs_without_citrix source TC35
    [Documentation]       Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file in ocs_without_citrix destination TC37
    Depends on test       Checking Network_Interface file size in ocs_without_citrix source TC36
    [Documentation]       Checking for Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file size in ocs_without_citrix destination TC38
    Depends on test       Checking Network_Interface file in ocs_without_citrix destination TC37
    [Documentation]       Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Network_Interface_${yesterday_ymd}.tsv

Checking Physical_Disk file in ocs_without_citrix source TC39
    [Documentation]       Checking for  Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file size in ocs_without_citrix source TC40
    Depends on test       Checking Physical_Disk file in ocs_without_citrix source TC39
    [Documentation]       Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file in ocs_without_citrix destination TC41
    Depends on test       Checking Physical_Disk file size in ocs_without_citrix source TC40
    [Documentation]       Checking for Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file size in ocs_without_citrix destination TC42
    Depends on test       Checking Physical_Disk file in ocs_without_citrix destination TC41
    [Documentation]       Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Physical_Disk_${yesterday_ymd}.tsv

Checking Processor file in ocs_without_citrix source TC43
    [Documentation]       Checking for  Processor_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Processor_${yesterday_ymd}.tsv

Checking Processor file size in ocs_without_citrix source TC44
    Depends on test       Checking Processor file in ocs_without_citrix source TC43
    [Documentation]       Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Processor_${yesterday_ymd}.tsv

Checking Processor file in ocs_without_citrix destination TC45
    Depends on test       Checking Processor file size in ocs_without_citrix source TC44
    [Documentation]       Checking for Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Processor_${yesterday_ymd}.tsv

Checking Processor file size in ocs_without_citrix destination TC46
    Depends on test       Checking Processor file in ocs_without_citrix destination TC45
    [Documentation]       Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/eniq/OCS/VDA_system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/eniq/OCS/VDA_system_logs/Processor_${yesterday_ymd}.tsv

Checking Redirector file in ocs_without_citrix source TC47
    [Documentation]       Checking for  Redirector_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file size in ocs_without_citrix source TC48
    Depends on test       Checking Redirector file in ocs_without_citrix source TC47
    [Documentation]       Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file in ocs_without_citrix destination TC49
    Depends on test       Checking Redirector file size in ocs_without_citrix source TC48
    [Documentation]       Checking for Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Redirector_${yesterday_ymd}.tsv

Checking Redirector file size in ocs_without_citrix destination TC50
    Depends on test       Checking Redirector file in ocs_without_citrix destination TC49
    [Documentation]       Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Redirector_${yesterday_ymd}.tsv

Checking Server file in ocs_without_citrix source TC51
    [Documentation]       Checking for  Server_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Server_${yesterday_ymd}.tsv

Checking Server file size in ocs_without_citrix source TC52
    Depends on test       Checking Server file in ocs_without_citrix source TC51
    [Documentation]       Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Server_${yesterday_ymd}.tsv

Checking Server file in ocs_without_citrix destination TC53
    Depends on test       Checking Server file size in ocs_without_citrix source TC52
    [Documentation]       Checking for Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Server_${yesterday_ymd}.tsv

Checking Server file size in ocs_without_citrix destination TC54
    Depends on test       Checking Server file in ocs_without_citrix destination TC53
    [Documentation]       Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Server_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in ocs_without_citrix source TC55
    [Documentation]       Checking for  Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file size in ocs_without_citrix source TC56
    Depends on test       Checking Server_Work_Queues file in ocs_without_citrix source TC55
    [Documentation]       Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in ocs_without_citrix destination TC57
    Depends on test       Checking Server_Work_Queues file size in ocs_without_citrix source TC56
    [Documentation]       Checking for Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file size in ocs_without_citrix destination TC58
    Depends on test       Checking Server_Work_Queues file in ocs_without_citrix destination TC57
    [Documentation]       Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/Server_Work_Queues_${yesterday_ymd}.tsv

Checking System file in ocs_without_citrix source TC59
    [Documentation]       Checking for  System_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/System_${yesterday_ymd}.tsv

Checking System file size in ocs_without_citrix source TC60
    Depends on test       Checking System file in ocs_without_citrix source TC59
    [Documentation]       Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/System_${yesterday_ymd}.tsv

Checking System file in ocs_without_citrix destination TC61
    Depends on test       Checking System file size in ocs_without_citrix source TC60
    [Documentation]       Checking for System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_${yesterday_ymd}.tsv

Checking System file size in ocs_without_citrix destination TC62
    Depends on test       Checking System file in ocs_without_citrix destination TC61
    [Documentation]       Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_${yesterday_ymd}.tsv

Checking System_Certificate_expiry file in ocs_without_citrix source TC63
    [Documentation]       Checking for  System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/System_Certificate_expiry_${yesterday_ymd}.tsv

Checking System_Certificate_expiry file size in ocs_without_citrix source TC64
    Depends on test       Checking System_Certificate_expiry file in ocs_without_citrix source TC63
    [Documentation]       Checking for non empty System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/System_Certificate_expiry_${yesterday_ymd}.tsv

Checking System_Certificate_expiry file in ocs_without_citrix destination TC65
    Depends on test       Checking System_Certificate_expiry file size in ocs_without_citrix source TC64
    [Documentation]       Checking for System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_Certificate_expiry_${yesterday_ymd}.tsv

Checking System_Certificate_expiry file size in ocs_without_citrix destination TC66
    Depends on test       Checking System_Certificate_expiry file in ocs_without_citrix destination TC65
    [Documentation]       Checking for non empty System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_Certificate_expiry_${yesterday_ymd}.tsv

Checking System_All file in ocs_without_citrix source TC67
    [Documentation]       Checking for  System_All_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/System_All_${yesterday_ymd}.tsv

Checking System_All file size in ocs_without_citrix source TC68
    Depends on test       Checking System_All file in ocs_without_citrix source TC67
    [Documentation]       Checking for non empty System_All_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/System_All_${yesterday_ymd}.tsv

Checking System_All file in ocs_without_citrix destination TC69
    Depends on test       Checking System_All file size in ocs_without_citrix source TC68
    [Documentation]       Checking for System_All_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_All_${yesterday_ymd}.tsv

Checking System_All file size in ocs_without_citrix destination TC70
    Depends on test       Checking System_All file in ocs_without_citrix destination
    [Documentation]       Checking for non empty System_All_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_All_${yesterday_ymd}.tsv

Checking System_BO file in ocs_without_citrix source TC71
    [Documentation]       Checking for  System_BO_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/OCS-WITHOUT-CITRIX/system_logs/System_BO_${yesterday_ymd}.tsv

Checking System_BO file size in ocs_without_citrix source TC72
    Depends on test       Checking System_BO file in ocs_without_citrix source TC71
    [Documentation]       Checking for non empty System_BO_${yesterday_ymd}.tsv log file in /eniq/OCS-WITHOUT-CITRIX/system_logs directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/OCS-WITHOUT-CITRIX/system_logs/System_BO_${yesterday_ymd}.tsv

Checking System_BO file in ocs_without_citrix destination TC73
    Depends on test       Checking System_BO file size in ocs_without_citrix source TC72
    [Documentation]       Checking for System_BO_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_BO_${yesterday_ymd}.tsv

Checking System_BO file size in ocs_without_citrix destination TC74
    Depends on test       Checking System_BO file in ocs_without_citrix destination TC73
    [Documentation]       Checking for non empty System_BO_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system directory
    [Tags]                OCS_WITHOUT_CITRIX
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/ocs_without_citrix_system/System_BO_${yesterday_ymd}.tsv

Unmounting_logs TC75
    [Documentation]           Checking for unmounting logs from mounting directory
    [Tags]                    OCS_WITHOUT_CITRIX
    unmounting logs           ${ocs_without_citrix_mount_path}

Archive_yesterday_log TC76
    [Documentation]             Taring processing of yesterday logs
    [Tags]                      OCS_WITHOUT_CITRIX
    ${taring_log_file}=         Execute Command    cd /eniq/log/ddc_data/${hostname}/uploaded/ && gtar czf DDC_Data_${yesterday_date_dmy}.tar.gz  ${yesterday_date_dmy}
    ${removing_date_file}=      Execute Command    cd /eniq/log/ddc_data/${hostname}/uploaded/ && rm -rf ${yesterday_date_dmy}
