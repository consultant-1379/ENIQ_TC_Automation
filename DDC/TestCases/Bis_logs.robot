*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking bis ip file TC01
    [Documentation]           Checking for ${bis_ip_file} log file in /eniq/installation/config/windows_server_conf_files directory
    [Tags]                    Bis
    ${bis_ip_file}=           Execute Command    ls -lrt /eniq/installation/config/windows_server_conf_files | grep "BIS" | tr -s ' ' | cut -d ' ' -f9
    Set Global Variable       ${bis_ip_file}
    Check File Exists         /eniq/installation/config/windows_server_conf_files/${bis_ip_file}

Checking bis ip addr TC02
    Depends on test           Checking bis ip file TC01
    [Documentation]           Check BIS Ip addr
    [Tags]                    Bis
    ${bis_ip_addr}=           Execute Command   echo ${bis_ip_file} | awk -F "-" '{print $2}'
    Set Global Variable       ${bis_ip_addr}

Checking bis mounting path TC03
    Depends On Test           Checking bis ip addr TC02
    [Documentation]           Check whether BIS mount path is available or not
    [Tags]                    Bis
    ${mounting_logs}=         Execute Command   mount -t nfs ${bis_ip_addr}:/DDC_logs ${bis_mount_path} -o ro,soft,vers=3,nosuid,nodev,nordirplus
    ${log_files}              Execute Command    cd ${bis_mount_path} && ls
    Count Of Files     ${bis_mount_path}
    #Should Be Equal As Strings    ${count}    3

Finding untar yesterday log TC04
    [Documentation]           Finding and untaring yesterday logs
    [Tags]                    Bis
    ${finding_untaring_file}=         Execute Command    find /eniq/log/ddc_data/${hostname}/uploaded/ -name "DDC_Data_${yesterday_date_dmy}.tar.gz" -printf "%T@ %p\n" | cut -d'/' -f7-
    ${untaring_file}=         Execute Command    cd /eniq/log/ddc_data/${hostname}/uploaded/ && tar -xzvf ${finding_untaring_file}

Checking bis hostname file in source TC05
    [Documentation]           Checking for hostname.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/hostname.tsv

Checking bis hostname file size in source TC06
    Depends on test           Checking bis hostname file in source TC05
    [Documentation]           Checking for non empty hostname.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/hostname.tsv

Checking bis hostname file in destination TC07
    Depends on test           Checking bis hostname file size in source TC06
    [Documentation]           Checking for hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bishost}=           Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/hostname.tsv
    Set Global Variable    ${des_bishost}
    Log To Console    ${des_bishost}
    IF    ${des_bishost} == True
        Pass Execution     hostname.tsv log file is available
    ELSE
        Skip    hostname.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking bis hostname file size in destination TC08
    Depends on test           Checking bis hostname file in destination TC07
    [Documentation]           Checking for non empty hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/hostname.tsv

#Checking for count of bis system log files in source
#   [Documentation]               Checking for count of log files in /eniq/BIS/system_logs directory
#   [Tags]                        Bis
#    ${log_files}                  Execute Command    find /eniq/BIS/system_logs/*_${yesterday_ymd}.tsv
#    Count Of Files                /eniq/BIS/system_logs/*_${yesterday_ymd}.tsv
#    ${bis_system_log_count}=      Run Keyword And Return Status     Should Be Equal As Strings    ${count}    17
#    Set Global Variable           ${bis_system_log_count}
#    Log To Console                ${bis_system_log_count}
#    Run Keyword If    ${bis_system_log_count} == False    Skip    bis_system_log_count doesn't match to 17.

#Checking for count of bis system log files in destination
#    Skip If    ${bis_system_log_count} == False
#    Depends on test               Checking for count of bis system log files in source
#    [Documentation]               Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
#    [Tags]                        Bis
#    Count Of Files                /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/*_${yesterday_ymd}.tsv
#    Should Be Equal As Strings    ${count}    17

#Checking for missing system bis log files
#    Skip If    ${bis_system_log_count} == False
#    [Documentation]           Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
#    [Tags]                    Bis
#    Check Missing File        /eniq/BIS/system_logs/*_${yesterday_ymd}.tsv    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/*_${yesterday_ymd}.tsv

Checking BO_Version file in bis source TC09
    [Documentation]           Checking for BO_Version_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/BO_Version_${yesterday_ymd}.tsv

Checking BO_Version file size in bis source TC10
    Depends on test           Checking BO_Version file in bis source TC09
    [Documentation]           Checking for non empty BO_Version_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/BO_Version_${yesterday_ymd}.tsv

Checking BO_Version file in bis destination TC11
    Depends on test           Checking BO_Version file size in bis source TC10
    [Documentation]           Checking for BO_Version_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisbo}=             Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/BO_Version_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisbo}
    Log To Console    ${des_bisbo}
    IF    ${des_bisbo} == True
        Pass Execution     BO_Version_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    BO_Version_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking BO_Version file size in bis destination TC12
    Depends on test           Checking BO_Version file in bis destination TC11
    [Documentation]           Checking for non empty BO_Version_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/BO_Version_${yesterday_ymd}.tsv

Checking Drive_Info file in bis source TC13
    [Documentation]           Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file size in bis source TC14
    Depends on test           Checking Drive_Info file in bis source TC13
    [Documentation]           Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file in bis destination TC15
    Depends on test           Checking Drive_Info file size in bis source TC14
    [Documentation]           Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisdrive}=          Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Drive_Info_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisdrive}
    Log To Console    ${des_bisdrive}
    IF    ${des_bisdrive} == True
        Pass Execution     Drive_Info_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Drive_Info_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Drive_Info file size in bis destination TC16
    Depends on test           Checking Drive_Info file in bis destination TC15
    [Documentation]           Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Drive_Info_${yesterday_ymd}.tsv

Checking Hardware_Details file in bis source TC17
    [Documentation]           Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file size in bis source TC18
    Depends on test           Checking Hardware_Details file in bis source TC17
    [Documentation]           Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file in bis destination TC19
    Depends on test           Checking Hardware_Details file size in bis source TC18
    [Documentation]           Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bishard}=           Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Hardware_Details_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bishard}
    Log To Console    ${des_bishard}
    IF    ${des_bishard} == True
        Pass Execution     Hardware_Details_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Hardware_Details_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Hardware_Details file size in bis destination TC20
    Depends on test           Checking Hardware_Details file in bis destination TC19
    [Documentation]           Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Hardware_Details_${yesterday_ymd}.tsv

Checking Logical_Disk file in bis source TC21
    [Documentation]           Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file size in bis source TC22
    Depends on test           Checking Logical_Disk file in bis source TC21
    [Documentation]           Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file in bis destination TC23
    Depends on test           Checking Logical_Disk file size in bis source TC22
    [Documentation]           Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bislogic}=          Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Logical_Disk_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bislogic}
    Log To Console    ${des_bislogic}
    IF    ${des_bislogic} == True
        Pass Execution     Logical_Disk_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Logical_Disk_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Logical_Disk file size in bis destination TC24
    Depends on test           Checking Logical_Disk file in bis destination TC23
    [Documentation]           Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Logical_Disk_${yesterday_ymd}.tsv

Checking Memory file in bis source TC25
    [Documentation]           Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Memory_${yesterday_ymd}.tsv

Checking Memory file size in bis source TC26
    Depends on test           Checking Memory file in bis source TC25
    [Documentation]           Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Memory_${yesterday_ymd}.tsv

Checking Memory file in bis destination TC27
    Depends on test           Checking Memory file size in bis source TC26
    [Documentation]           Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bismemory}=         Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Memory_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bismemory}
    Log To Console    ${des_bismemory}
    IF    ${des_bismemory} == True
        Pass Execution     Memory_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Memory_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Memory file size in bis destination TC28
    Depends on test           Checking Memory file in bis destination TC27
    [Documentation]           Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Memory_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in bis source TC29
    [Documentation]           Checking for Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file size in bis source TC30
    Depends on test           Checking Memory_Related_Counters file in bis source TC29
    [Documentation]           Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in bis destination TC31
    Depends on test           Checking Memory_Related_Counters file size in bis source TC30
    [Documentation]           Checking for Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_biscount}=          Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Memory_Related_Counters_${yesterday_ymd}.tsv
    Set Global Variable    ${des_biscount}
    Log To Console    ${des_biscount}
    IF    ${des_biscount} == True
        Pass Execution     Memory_Related_Counters_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Memory_Related_Counters_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Memory_Related_Counters file size in bis destination TC32
    Depends on test           Checking Memory_Related_Counters file in bis destination TC31
    [Documentation]           Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking NBT_Connections file in bis source TC33
    [Documentation]           Checking for NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file size in bis source TC34
    Depends on test           Checking NBT_Connections file in bis source TC33
    [Documentation]           Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file in bis destination TC35
    Depends on test           Checking NBT_Connections file size in bis source TC34
    [Documentation]           Checking for NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisnbt}=            Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/NBT_Connections_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisnbt}
    Log To Console    ${des_bisnbt}
    IF    ${des_bisnbt} == True
        Pass Execution     NBT_Connections_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    NBT_Connections_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking NBT_Connections file size in bis destination TC36
    Depends on test           Checking NBT_Connections file in bis destination TC35
    [Documentation]           Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/NBT_Connections_${yesterday_ymd}.tsv

Checking Network_Interface file in bis source TC37
    [Documentation]           Checking for Network_Interface_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file size in bis source TC38
    Depends on test           Checking Network_Interface file in bis source TC37
    [Documentation]           Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file in bis destination TC39
    Depends on test           Checking Network_Interface file size in bis source TC38
    [Documentation]           Checking for Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisnet}=            Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Network_Interface_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisnet}
    Log To Console    ${des_bisnet}
    IF    ${des_bisnet} == True
        Pass Execution     Network_Interface_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Network_Interface_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Network_Interface file size in bis destination TC40
    Depends on test           Checking Network_Interface file in bis destination TC39
    [Documentation]           Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Network_Interface_${yesterday_ymd}.tsv

Checking Physical_Disk file in bis source TC41
    [Documentation]           Checking for Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file size in bis source TC42
    Depends on test           Checking Physical_Disk file in bis source TC41
    [Documentation]           Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file in bis destination TC43
    Depends on test           Checking Physical_Disk file size in bis source TC42
    [Documentation]           Checking for Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisdisk}=           Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Physical_Disk_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisdisk}
    Log To Console    ${des_bisdisk}
    IF    ${des_bisdisk} == True
        Pass Execution     Physical_Disk_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Physical_Disk_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Physical_Disk file size in bis destination TC44
    Depends on test           Checking Physical_Disk file in bis destination TC43
    [Documentation]           Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Physical_Disk_${yesterday_ymd}.tsv

Checking Processor file in bis source TC45
    [Documentation]           Checking for Processor_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Processor_${yesterday_ymd}.tsv

Checking Processor file size in bis source TC46
    Depends on test           Checking Processor file in bis source TC45
    [Documentation]           Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Processor_${yesterday_ymd}.tsv

Checking Processor file in bis destination TC47
    Depends on test           Checking Processor file size in bis source TC46
    [Documentation]           Checking for Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisproc}=           Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Processor_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisproc}
    Log To Console    ${des_bisproc}
    IF    ${des_bisproc} == True
        Pass Execution     Processor_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Processor_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Processor file size in bis destination TC48
    Depends on test           Checking Processor file in bis destination TC47
    [Documentation]           Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Processor_${yesterday_ymd}.tsv

Checking Redirector file in bis source TC49
    [Documentation]           Checking for Redirector_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file size in bis source TC50
    Depends on test           Checking Redirector file in bis source TC49
    [Documentation]           Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file in bis destination TC51
    Depends on test           Checking Redirector file size in bis source TC50
    [Documentation]           Checking for Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisredir}=          Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Redirector_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisredir}
    Log To Console    ${des_bisredir}
    IF    ${des_bisredir} == True
        Pass Execution     Redirector_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Redirector_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Redirector file size in bis destination TC52
    Depends on test           Checking Redirector file in bis destination TC51
    [Documentation]           Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Redirector_${yesterday_ymd}.tsv

Checking Server file in bis source TC53
    [Documentation]           Checking for Server_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Server_${yesterday_ymd}.tsv

Checking Server file size in bis source TC54
    Depends on test           Checking Server file in bis source TC53
    [Documentation]           Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Server_${yesterday_ymd}.tsv

Checking Server file in bis destination TC55
    Depends on test           Checking Server file size in bis source TC54
    [Documentation]           Checking for Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisser}=            Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Server_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisser}
    Log To Console    ${des_bisser}
    IF    ${des_bisser} == True
        Pass Execution     Server_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Server_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Server file size in bis destination TC56
    Depends on test           Checking Server file in bis destination TC55
    [Documentation]           Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Server_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in bis source TC57
    [Documentation]           Checking for Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file size in bis source TC58
    Depends on test           Checking Server_Work_Queues file in bis source TC57
    [Documentation]           Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in bis destination TC59
    Depends on test           Checking Server_Work_Queues file size in bis source TC58
    [Documentation]           Checking for Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bisque}=            Run Keyword And Return Status     Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Server_Work_Queues_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bisque}
    Log To Console    ${des_bisque}
    IF    ${des_bisque} == True
        Pass Execution     Server_Work_Queues_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     Server_Work_Queues_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Server_Work_Queues file size in bis destination TC60
    Depends on test           Checking Server_Work_Queues file in bis destination TC59
    [Documentation]           Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/Server_Work_Queues_${yesterday_ymd}.tsv

Checking System file in bis source TC61
    [Documentation]           Checking for System_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/System_${yesterday_ymd}.tsv

Checking System file size in bis source TC62
    Depends on test           Checking System file in bis source TC61
    [Documentation]           Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/System_${yesterday_ymd}.tsv

Checking System file in bis destination TC63
    Depends on test           Checking System file size in bis source TC62
    [Documentation]           Checking for System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bissys}=            Run Keyword And Return Status    Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bissys}
    Log To Console    ${des_bissys}
    IF    ${des_bissys} == True
        Pass Execution     System_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     System_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking System file size in bis destination TC64
    Depends on test           Checking System file in bis destination TC63
    [Documentation]           Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_${yesterday_ymd}.tsv

Checking System_All file in bis source TC65
    [Documentation]           Checking for System_All_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/System_All_${yesterday_ymd}.tsv

Checking System_All file size in bis source TC66
    Depends on test           Checking System_All file in bis source TC65
    [Documentation]           Checking for non empty System_All_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/System_All_${yesterday_ymd}.tsv

Checking System_All file in bis destination TC67
    Depends on test           Checking System_All file size in bis source TC66
    [Documentation]           Checking for System_All_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bissysall}=         Run Keyword And Return Status    Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_All_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bissysall}
    Log To Console    ${des_bissysall}
    IF    ${des_bissysall} == True
        Pass Execution     System_All_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     System_All_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking System_All file size in bis destination TC68
    Depends on test           Checking System_All file in bis destination TC67
    [Documentation]           Checking for non empty System_All_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_All_${yesterday_ymd}.tsv

Checking System_BO file in bis source TC69
    [Documentation]           Checking for System_BO_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Exists         /eniq/BIS/system_logs/System_BO_${yesterday_ymd}.tsv

Checking System_BO file size in bis source TC70
    Depends on test           Checking System_BO file in bis source TC69
    [Documentation]           Checking for non empty System_BO_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
    [Tags]                    Bis
    Check File Size           /eniq/BIS/system_logs/System_BO_${yesterday_ymd}.tsv

Checking System_BO file in bis destination TC71
    Depends on test           Checking System_BO file size in bis source TC70
    [Documentation]           Checking for System_BO_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    ${des_bissysbo}=          Run Keyword And Return Status    Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_BO_${yesterday_ymd}.tsv
    Set Global Variable    ${des_bissysbo}
    Log To Console    ${des_bissysbo}
    IF    ${des_bissysbo} == True
        Pass Execution     System_BO_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip     System_BO_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking System_BO file size in bis destination TC72
    Depends on test           Checking System_BO file in bis destination TC71
    [Documentation]           Checking for non empty System_BO_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
    [Tags]                    Bis
    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_BO_${yesterday_ymd}.tsv

#Checking System_Certificate_expiry file in bis source
#    [Documentation]           Checking for System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
#    [Tags]                    Bis
#    Check File Exists         /eniq/BIS/system_logs/System_Certificate_expiry_${yesterday_ymd}.tsv

#Checking System_Certificate_expiry file size in bis source
#   Depends on test           Checking System_Certificate_expiry file in bis source
#   [Documentation]           Checking for non empty System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/BIS/system_logs directory
#   [Tags]                    Bis
#   Check File Size           /eniq/BIS/system_logs/System_Certificate_expiry_${yesterday_ymd}.tsv

#Checking System_Certificate_expiry file in bis destination
#   Depends on test           Checking System_Certificate_expiry file size in bis source
#    [Documentation]           Checking for System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
#    [Tags]                    Bis
#    Check File Exists         /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_Certificate_expiry_${yesterday_ymd}.tsv

#Checking System_Certificate_expiry file size in bis destination
#    Depends on test           Checking System_Certificate_expiry file in bis destination
#    [Documentation]           Checking for non empty System_Certificate_expiry_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system directory
#    [Tags]                    Bis
#    Check File Size           /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_system/System_Certificate_expiry_${yesterday_ymd}.tsv

#Checking for count of bis application log files in source
#    [Documentation]                   Checking for count of log files in /eniq/BIS/application_logs directory
#    [Tags]                            Bis
#    Count Of Files                    /eniq/BIS/application_logs/*${yesterday_ymd}.txt
#    ${bis_application_log_count}=     Run Keyword And Return Status     Should Be Equal As Strings    ${count}    7
#    Set Global Variable               ${bis_application_log_count}
#    Log To Console                    ${bis_application_log_count}
#    Run Keyword If    ${bis_application_log_count} == False    Skip    bis_application_log_count doesn't match to 7.

#Checking for count of bis application log files in destination
#    Skip If    ${bis_application_log_count} == False
#    Depends on test               Checking for count of bis application log files in source
#    [Documentation]               Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
#    [Tags]                        Bis
#    Count Of Files                /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/*${yesterday_ymd}.txt
#    Should Be Equal As Strings    ${count}    7

#Checking for missing application bis log files
#    Skip If    ${bis_application_log_count} == False
#    [Documentation]               Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
#    [Tags]                        Bis
#    Check Missing File            /eniq/BIS/application_logs/*${yesterday_ymd}.txt    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/*${yesterday_ymd}.txt

Checking ActiveUsers file in bis source TC73
    [Documentation]               Checking for ActiveUsers${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/ActiveUsers${yesterday_ymd}.txt

Checking ActiveUsers file size in bis source TC74
    Depends on test               Checking ActiveUsers file in bis source TC73
    [Documentation]               Checking for non empty ActiveUsers${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/ActiveUsers${yesterday_ymd}.txt

Checking ActiveUsers file in bis destination TC75
    Depends on test               Checking ActiveUsers file size in bis source TC74
    [Documentation]               Checking for ActiveUsers${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisactive}=             Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ActiveUsers${yesterday_ymd}.txt
    Set Global Variable    ${des_bisactive}
    Log To Console    ${des_bisactive}
    IF    ${des_bisactive} == True
        Pass Execution     ActiveUsers${yesterday_ymd}.txt log file is available
    ELSE
        Skip     ActiveUsers${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking ActiveUsers file size in bis destination TC76
    Depends on test               Checking ActiveUsers file in bis destination TC75
    [Documentation]               Checking for non empty ActiveUsers${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ActiveUsers${yesterday_ymd}.txt

Checking PromptInfo file in bis source TC77
    [Documentation]               Checking for PromptInfo${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/PromptInfo${yesterday_ymd}.txt

Checking PromptInfo file size in bis source TC78
    Depends on test               Checking PromptInfo file in bis source TC77
    [Documentation]               Checking for non empty PromptInfo${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/PromptInfo${yesterday_ymd}.txt

Checking PromptInfo file in bis destination TC79
    Depends on test               Checking PromptInfo file size in bis source TC78
    [Documentation]               Checking for PromptInfo${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisprompt}=             Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/PromptInfo${yesterday_ymd}.txt
    Set Global Variable    ${des_bisprompt}
    Log To Console    ${des_bisprompt}
    IF    ${des_bisprompt} == True
        Pass Execution     PromptInfo${yesterday_ymd}.txt log file is available
    ELSE
        Skip     PromptInfo${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PromptInfo file size in bis destination TC80
    Depends on test               Checking PromptInfo file in bis destination TC79
    [Documentation]               Checking for non empty PromptInfo${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/PromptInfo${yesterday_ymd}.txt

Checking ReportInstances file in bis source TC81
    [Documentation]               Checking for ReportInstances${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/ReportInstances${yesterday_ymd}.txt

Checking ReportInstances file size in bis source TC82
    Depends on test               Checking ReportInstances file in bis source TC81
    [Documentation]               Checking for non empty ReportInstances${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/ReportInstances${yesterday_ymd}.txt

Checking ReportInstances file in bis destination TC83
    Depends on test               Checking ReportInstances file size in bis source TC82
    [Documentation]               Checking for ReportInstances${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisreport}=             Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportInstances${yesterday_ymd}.txt
    Set Global Variable    ${des_bisreport}
    Log To Console    ${des_bisreport}
    IF    ${des_bisreport} == True
        Pass Execution     ReportInstances${yesterday_ymd}.txt log file is available
    ELSE
        Skip     ReportInstances${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking ReportInstances file size in bis destination TC84
    Depends on test               Checking ReportInstances file in bis destination TC83
    [Documentation]               Checking for non empty ReportInstances${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportInstances${yesterday_ymd}.txt

Checking ReportList file in bis source TC85
    [Documentation]               Checking for ReportList${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/ReportList${yesterday_ymd}.txt

Checking ReportList file size in bis source TC86
    Depends on test               Checking ReportList file in bis source TC85
    [Documentation]               Checking for non empty ReportList${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/ReportList${yesterday_ymd}.txt

Checking ReportList file in bis destination TC87
    Depends on test               Checking ReportList file size in bis source TC86
    [Documentation]               Checking for ReportList${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bislist}=               Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportList${yesterday_ymd}.txt
    Set Global Variable    ${des_bislist}
    Log To Console    ${des_bislist}
    IF    ${des_bislist} == True
        Pass Execution     ReportList${yesterday_ymd}.txt log file is available
    ELSE
        Skip     ReportList${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking ReportList file size in bis destination TC88
    Depends on test               Checking ReportList file in bis destination TC87
    [Documentation]               Checking for non empty ReportList${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportList${yesterday_ymd}.txt

Checking ReportRefreshTime file in bis source TC89
    [Documentation]               Checking for ReportRefreshTime${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/ReportRefreshTime${yesterday_ymd}.txt

Checking ReportRefreshTime file size in bis source TC90
    Depends on test               Checking ReportRefreshTime file in bis source TC89
    [Documentation]               Checking for non empty ReportRefreshTime${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/ReportRefreshTime${yesterday_ymd}.txt

Checking ReportRefreshTime file in bis destination TC91
    Depends on test               Checking ReportRefreshTime file size in bis source TC90
    [Documentation]               Checking for ReportRefreshTime${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisreftime}=            Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportRefreshTime${yesterday_ymd}.txt
    Set Global Variable    ${des_bisreftime}
    Log To Console    ${des_bisreftime}
    IF    ${des_bisreftime} == True
        Pass Execution     ReportRefreshTime${yesterday_ymd}.txt log file is available
    ELSE
        Skip     ReportRefreshTime${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking ReportRefreshTime file size in bis destination TC92
    Depends on test               Checking ReportRefreshTime file in bis destination TC91
    [Documentation]               Checking for non empty ReportRefreshTime${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/ReportRefreshTime${yesterday_ymd}.txt

Checking SchedulingInfo file in bis source TC93
    [Documentation]               Checking for SchedulingInfo${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/SchedulingInfo${yesterday_ymd}.txt

Checking SchedulingInfo file size in bis source TC94
    Depends on test               Checking SchedulingInfo file in bis source TC93
    [Documentation]               Checking for non empty SchedulingInfo${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/SchedulingInfo${yesterday_ymd}.txt

Checking SchedulingInfo file in bis destination TC95
    Depends on test               Checking SchedulingInfo file size in bis source TC94
    [Documentation]               Checking for SchedulingInfo${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisschedul}=            Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/SchedulingInfo${yesterday_ymd}.txt
    Set Global Variable    ${des_bisschedul}
    Log To Console    ${des_bisschedul}
    IF    ${des_bisschedul} == True
        Pass Execution     SchedulingInfo${yesterday_ymd}.txt log file is available
    ELSE
        Skip     SchedulingInfo${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking SchedulingInfo file size in bis destination TC96
    Depends on test               Checking SchedulingInfo file in bis destination TC95
    [Documentation]               Checking for non empty SchedulingInfo${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/SchedulingInfo${yesterday_ymd}.txt

Checking UserList file in bis source TC97
    [Documentation]               Checking for UserList${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Exists             /eniq/BIS/application_logs/UserList${yesterday_ymd}.txt

Checking UserList file size in bis source TC98
    Depends on test               Checking UserList file in bis source TC97
    [Documentation]               Checking for non empty UserList${yesterday_ymd}.txt log file in /eniq/BIS/application_logs directory
    [Tags]                        Bis
    Check File Size               /eniq/BIS/application_logs/UserList${yesterday_ymd}.txt

Checking UserList file in bis destination TC99
    Depends on test               Checking UserList file size in bis source TC98
    [Documentation]               Checking for UserList${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    ${des_bisusrlist}=            Run Keyword And Return Status     Check File Exists             /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/UserList${yesterday_ymd}.txt
    Set Global Variable    ${des_bisusrlist}
    Log To Console    ${des_bisusrlist}
    IF    ${des_bisusrlist} == True
        Pass Execution     UserList${yesterday_ymd}.txt log file is available
    ELSE
        Skip     UserList${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking UserList file size in bis destination TC100
    Depends on test               Checking UserList file in bis destination TC99
    [Documentation]               Checking for non empty UserList${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application directory
    [Tags]                        Bis
    Check File Size               /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/bis_application/UserList${yesterday_ymd}.txt

Unmounting_logs TC101
    [Documentation]           Checking for unmounting logs from mounting directory
    [Tags]                    Bis
    unmounting logs           ${bis_mount_path}
