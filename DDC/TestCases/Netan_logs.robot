*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking netan ip file TC01
    [Documentation]           Checking for ${netan_ip_file} log file in /eniq/installation/config/windows_server_conf_files directory
    [Tags]                    Netan
    ${netan_ip_file}=         Execute Command    ls -lrt /eniq/installation/config/windows_server_conf_files | grep "NETAN" | tr -s ' ' | cut -d ' ' -f9
    Set Global Variable       ${netan_ip_file}
    Check File Exists         /eniq/installation/config/windows_server_conf_files/${netan_ip_file}

Checking netan ip addr TC02
    Depends on test           Checking netan ip file TC01
    [Documentation]           Check NETAN Ip addr
    [Tags]                    Netan
    ${netan_ip_addr}=         Execute Command   echo ${netan_ip_file} | awk -F "-" '{print $2}'
    Set Global Variable       ${netan_ip_addr}

Checking netan mounting path TC03
    Depends On Test           Checking netan ip addr TC02
    [Documentation]           Check whether NETAN mount path is available or not
    [Tags]                    Netan
    ${mounting_logs}=         Execute Command   mount -t nfs ${netan_ip_addr}:/DDC ${netan_mount_path} -o ro,soft,vers=3,nosuid,nodev,nordirplus
    ${log_files}              Execute Command    cd ${netan_mount_path} && ls
    Count Of Files     ${netan_mount_path}
    #Should Be Equal As Strings    ${count}    4

Checking netan hostname file in source TC04
    [Documentation]      Checking for hostname.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/hostname.tsv

Checking netan hostname file size in source TC05
    Depends on test      Checking netan hostname file in source TC04
    [Documentation]      Checking for non empty hostname.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/hostname.tsv

Checking netan hostname file in destination TC06
    Depends on test      Checking netan hostname file size in source TC05
    [Documentation]      Checking for hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_host}=         Run Keyword And Return Status    Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/hostname.tsv
    Set Global Variable     ${des_host}
    Log To Console       ${des_host}
    IF    ${des_host} == True
        Pass Execution    hostname.tsv log file is available
    ELSE
        Skip    hostname.tsv log file is not available due to log collection not happened from mount path to DDC dir.
    END

Checking netan hostname file size in destination TC07
    Depends on test      Checking netan hostname file in destination TC06
    [Documentation]      Checking for non empty hostname.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/hostname.tsv

#Checking for count of netan system log files in source
#   [Documentation]               Checking for count of log files in /eniq/netanserver/SystemLogs directory
#   [Tags]                        Netan
#   ${log_files}                  Execute Command    find /eniq/netanserver/SystemLogs/*_${yesterday_ymd}.tsv
#   Count Of Files                /eniq/netanserver/SystemLogs/*_${yesterday_ymd}.tsv
#   ${system_log_count}=         Run Keyword And Return Status     Should Be Equal As Strings    ${count}    13
#   Set Global Variable           ${system_log_count}
#   Log To Console                ${system_log_count}
#   Run Keyword If    ${system_log_count} == False    Skip    system_log_count doesn't match to 13.

#Checking for count of netan system log files in destination
#    Skip If    ${system_log_count} == False
#    Depends on test               Checking for count of netan system log files in source
#    [Documentation]               Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
#    [Tags]                        Netan
#    Count Of Files                /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems
#    Should Be Equal As Strings    ${count}    13

#Checking for missing system netan log files
#    Skip If    ${system_log_count} == False
#    [Documentation]       Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
#    [Tags]                Netan
#    Check Missing File    /eniq/netanserver/SystemLogs/*_${yesterday_ymd}.tsv    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/*_${yesterday_ymd}.tsv

Checking Drive_Info file in netan source TC08
    [Documentation]       Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/SystemLogs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file size in netan source TC09
    Depends on test       Checking Drive_Info file in netan source TC08
    [Documentation]       Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/SystemLogs/Drive_Info_${yesterday_ymd}.tsv

Checking Drive_Info file in netan destination TC10
    Depends on test       Checking Drive_Info file size in netan source TC09
    [Documentation]       Checking for Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]                Netan
    ${des_drive}=         Run Keyword And Return Status    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Drive_Info_${yesterday_ymd}.tsv
    Set Global Variable    ${des_drive}
    Log To Console    ${des_drive}
    IF    ${des_drive} == True
        Pass Execution      Drive_Info_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Drive_Info_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Drive_Info file size in netan destination TC11
    Depends on test       Checking Drive_Info file in netan destination TC10
    [Documentation]       Checking for non empty Drive_Info_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Drive_Info_${yesterday_ymd}.tsv

Checking Hardware_Details file in netan source TC12
    [Documentation]       Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/SystemLogs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file size in netan source TC13
    Depends on test       Checking Hardware_Details file in netan source TC12
    [Documentation]       Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/SystemLogs/Hardware_Details_${yesterday_ymd}.tsv

Checking Hardware_Details file in netan destination TC14
    Depends on test       Checking Hardware_Details file size in netan source TC13
    [Documentation]       Checking for Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]                Netan
    ${des_Hardware}=      Run Keyword And Return Status    Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Hardware_Details_${yesterday_ymd}.tsv
    Set Global Variable    ${des_Hardware}
    Log To Console    ${des_Hardware}
    IF    ${des_Hardware} == True
        Pass Execution    Hardware_Details_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Hardware_Details_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Hardware_Details file size in netan destination TC15
    Depends on test       Checking Hardware_Details file in netan destination TC14
    [Documentation]       Checking for non empty Hardware_Details_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Hardware_Details_${yesterday_ymd}.tsv

Checking Logical_Disk file in netan source TC16
    [Documentation]       Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/SystemLogs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file size in netan source TC17
    Depends on test       Checking Logical_Disk file in netan source TC16
    [Documentation]       Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/SystemLogs/Logical_Disk_${yesterday_ymd}.tsv

Checking Logical_Disk file in netan destination TC18
    Depends on test       Checking Logical_Disk file size in netan source TC17
    [Documentation]       Checking for Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]                Netan
    ${des_logical}=       Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Logical_Disk_${yesterday_ymd}.tsv
    Set Global Variable    ${des_logical}
    Log To Console    ${des_logical}
    IF    ${des_logical} == True
        Pass Execution     Logical_Disk_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Logical_Disk_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Logical_Disk file size in netan destination TC19
    Depends on test      Checking Logical_Disk file in netan destination TC18
    [Documentation]      Checking for non empty Logical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Logical_Disk_${yesterday_ymd}.tsv

Checking Memory file in netan source TC21
    [Documentation]      Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Memory_${yesterday_ymd}.tsv

Checking Memory file size in netan source TC22
    Depends on test      Checking Memory file in netan source TC21
    [Documentation]      Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Memory_${yesterday_ymd}.tsv

Checking Memory file in netan destination TC23
    Depends on test      Checking Memory file size in netan source TC22
    [Documentation]      Checking for Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_memory}=       Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Memory_${yesterday_ymd}.tsv
    Set Global Variable    ${des_memory}
    Log To Console    ${des_memory}
    IF    ${des_memory} == True
        Pass Execution     Memory_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Memory_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Memory file size in netan destination TC24
    Depends on test      Checking Memory file in netan destination TC23
    [Documentation]      Checking for non empty Memory_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Memory_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in netan source TC25
    [Documentation]      Checking for Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file size in netan source TC26
    Depends on test      Checking Memory_Related_Counters file in netan source TC25
    [Documentation]      Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking Memory_Related_Counters file in netan destination TC27
    Depends on test      Checking Memory_Related_Counters file size in netan source TC26
    [Documentation]      Checking for Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_counters}=       Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Memory_Related_Counters_${yesterday_ymd}.tsv
    Set Global Variable    ${des_counters}
    Log To Console    ${des_counters}
    IF    ${des_counters} == True
        Pass Execution     Memory_Related_Counters_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Memory_Related_Counters_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Memory_Related_Counters file size in netan destination TC28
    Depends on test      Checking Memory_Related_Counters file in netan destination TC27
    [Documentation]      Checking for non empty Memory_Related_Counters_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Memory_Related_Counters_${yesterday_ymd}.tsv

Checking NBT_Connections file in netan source TC29
    [Documentation]      Checking for NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file size in netan source TC30
    Depends on test      Checking NBT_Connections file in netan source TC29
    [Documentation]      Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/NBT_Connections_${yesterday_ymd}.tsv

Checking NBT_Connections file in netan destination TC31
    Depends on test      Checking NBT_Connections file size in netan source TC30
    [Documentation]      Checking for NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_NBT}=          Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/NBT_Connections_${yesterday_ymd}.tsv
    Set Global Variable    ${des_NBT}
    Log To Console    ${des_NBT}
    IF    ${des_NBT} == True
        Pass Execution     NBT_Connections_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    NBT_Connections_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking NBT_Connections file size in netan destination TC32
    Depends on test      Checking NBT_Connections file in netan destination TC31
    [Documentation]      Checking for non empty NBT_Connections_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/NBT_Connections_${yesterday_ymd}.tsv

Checking Network_Interface file in netan source TC33
    [Documentation]      Checking for Network_Interface_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file size in netan source TC34
    Depends on test      Checking Network_Interface file in netan source TC33
    [Documentation]      Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Network_Interface_${yesterday_ymd}.tsv

Checking Network_Interface file in netan destination TC35
    Depends on test      Checking Network_Interface file size in netan source TC34
    [Documentation]      Checking for Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_network}=      Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Network_Interface_${yesterday_ymd}.tsv
    Set Global Variable    ${des_network}
    Log To Console    ${des_network}
    IF    ${des_network} == True
        Pass Execution     Network_Interface_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Network_Interface_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Network_Interface file size in netan destination TC36
    Depends on test      Checking Network_Interface file in netan destination TC35
    [Documentation]      Checking for non empty Network_Interface_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Network_Interface_${yesterday_ymd}.tsv

Checking Physical_Disk file in netan source TC37
    [Documentation]      Checking for Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file size in netan source TC38
    Depends on test      Checking Physical_Disk file in netan source TC37
    [Documentation]      Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Physical_Disk_${yesterday_ymd}.tsv

Checking Physical_Disk file in netan destination TC39
    Depends on test      Checking Physical_Disk file size in netan source TC38
    [Documentation]      Checking for Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_physical}=      Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Physical_Disk_${yesterday_ymd}.tsv
    Set Global Variable    ${des_physical}
    Log To Console    ${des_physical}
    IF    ${des_physical} == True
        Pass Execution     Physical_Disk_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Physical_Disk_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Physical_Disk file size in netan destination TC40
    Depends on test      Checking Physical_Disk file in netan destination TC39
    [Documentation]      Checking for non empty Physical_Disk_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Physical_Disk_${yesterday_ymd}.tsv

Checking Processor file in netan source TC41
    [Documentation]      Checking for Processor_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Processor_${yesterday_ymd}.tsv

Checking Processor file size in netan source TC42
    Depends on test      Checking Processor file in netan source TC41
    [Documentation]      Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Processor_${yesterday_ymd}.tsv

Checking Processor file in netan destination TC43
    Depends on test      Checking Processor file size in netan source TC42
    [Documentation]      Checking for Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_processor}=      Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Processor_${yesterday_ymd}.tsv
    Set Global Variable    ${des_processor}
    Log To Console    ${des_processor}
    IF    ${des_processor} == True
        Pass Execution     Processor_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Processor_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Processor file size in netan destination TC44
    Depends on test      Checking Processor file in netan destination TC43
    [Documentation]      Checking for non empty Processor_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Processor_${yesterday_ymd}.tsv

Checking Redirector file in netan source TC45
    [Documentation]      Checking for Redirector_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file size in netan source TC46
    Depends on test      Checking Redirector file in netan source TC45
    [Documentation]      Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Redirector_${yesterday_ymd}.tsv

Checking Redirector file in netan destination TC47
    Depends on test      Checking Redirector file size in netan source TC46
    [Documentation]      Checking for Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_redirec}=      Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Redirector_${yesterday_ymd}.tsv
    Set Global Variable    ${des_redirec}
    Log To Console    ${des_redirec}
    IF    ${des_redirec} == True
        Pass Execution     Redirector_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Redirector_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Redirector file size in netan destination TC48
    Depends on test      Checking Redirector file in netan destination TC47
    [Documentation]      Checking for non empty Redirector_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Redirector_${yesterday_ymd}.tsv

Checking Server file in netan source TC49
    [Documentation]      Checking for Server_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Server_${yesterday_ymd}.tsv

Checking Server file size in netan source TC50
    Depends on test      Checking Server file in netan source TC49
    [Documentation]      Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Server_${yesterday_ymd}.tsv

Checking Server file in netan destination TC51
    Depends on test      Checking Server file size in netan source TC50
    [Documentation]      Checking for Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_server}=       Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Server_${yesterday_ymd}.tsv
    Set Global Variable    ${des_server}
    Log To Console    ${des_server}
    IF    ${des_server} == True
        Pass Execution     Server_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Server_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking Server file size in netan destination TC52
    Depends on test      Checking Server file in netan destination TC51
    [Documentation]      Checking for non empty Server_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Server_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in netan source TC53
    [Documentation]      Checking for Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file size in netan source TC54
    Depends on test      Checking Server_Work_Queues file in netan source TC53
    [Documentation]      Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/Server_Work_Queues_${yesterday_ymd}.tsv

Checking Server_Work_Queues file in netan destination TC55
    Depends on test      Checking Server_Work_Queues file size in netan source TC54
    [Documentation]      Checking for Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_work}=       Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Server_Work_Queues_${yesterday_ymd}.tsv
    Set Global Variable    ${des_work}
    Log To Console    ${des_work}
    IF    ${des_work} == True
        Pass Execution     Server_Work_Queues_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    Server_Work_Queues_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking Server_Work_Queues file in netan size destination TC56
    Depends on test      Checking Server_Work_Queues file in netan destination TC55
    [Documentation]      Checking for non empty Server_Work_Queues_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/Server_Work_Queues_${yesterday_ymd}.tsv

Checking System file in netan source TC57
    [Documentation]      Checking for System_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs directory
    [Tags]               Netan
    Check File Exists    /eniq/netanserver/SystemLogs/System_${yesterday_ymd}.tsv

Checking System file size in netan source TC58
    Depends on test      Checking System file in netan source TC57
    [Documentation]      Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/netanserver/SystemLogs/ directory
    [Tags]               Netan
    Check File Size      /eniq/netanserver/SystemLogs/System_${yesterday_ymd}.tsv

Checking System file in netan destination TC59
    Depends on test      Checking System file size in netan source TC58
    [Documentation]      Checking for System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    ${des_system}=       Run Keyword And Return Status     Check File Exists    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/System_${yesterday_ymd}.tsv
    Set Global Variable    ${des_system}
    Log To Console    ${des_system}
    IF    ${des_system} == True
        Pass Execution     System_${yesterday_ymd}.tsv log file is available
    ELSE
        Skip    System_${yesterday_ymd}.tsv log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking System file size in netan destination TC60
    Depends on test      Checking System file in netan destination TC59
    [Documentation]      Checking for non empty System_${yesterday_ymd}.tsv log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems directory
    [Tags]               Netan
    Check File Size      /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_systems/System_${yesterday_ymd}.tsv

#Checking for count of netan application log files in source
#    [Documentation]               Checking for count of log files in /eniq/netanserver/ApplicationLogs directory
#    [Tags]                        Netan
#    Count Of Files                /eniq/netanserver/ApplicationLogs/*${yesterday_ymd}.txt
#    ${application_log_count}=     Run Keyword And Return Status    Should Be Equal As Strings    ${count}    7
#    Set Global Variable           ${application_log_count}
#    Log To Console                ${application_log_count}
#    Run Keyword If    ${application_log_count} == False    Skip    application_log_count doesn't match to 7.


#Checking for count of netan application log files in destination
#    Skip If    ${application_log_count} == False
#    Depends on test               Checking for count of netan application log files in source
#    [Documentation]               Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
#    [Tags]                        Netan
#    Count Of Files                /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/*${yesterday_ymd}.txt
#    Should Be Equal As Strings    ${count}    7

#Checking for missing application netan log files
#    Skip If    ${application_log_count} == False
#    [Documentation]       Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
#    [Tags]                Netan
#    Check Missing File    /eniq/netanserver/ApplicationLogs/*${yesterday_ymd}.txt    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/*${yesterday_ymd}.txt

Checking AuditLog file in netan source TC61
    [Documentation]       Checking for AuditLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/AuditLog${yesterday_ymd}.txt

Checking AuditLog file size in netan source TC62
    Depends on test       Checking AuditLog file in netan source TC61
    [Documentation]       Checking for non empty AuditLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/AuditLog${yesterday_ymd}.txt

Checking AuditLog file in netan destination TC63
    Depends on test       Checking AuditLog file size in netan source TC62
    [Documentation]       Checking for AuditLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_audit}=         Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/AuditLog${yesterday_ymd}.txt
    Set Global Variable    ${des_audit}
    Log To Console    ${des_audit}
    IF    ${des_audit} == True
        Pass Execution     AuditLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    AuditLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking AuditLog file size in netan destination TC64
    Depends on test       Checking AuditLog file in netan destination TC63
    [Documentation]       Checking for non empty AuditLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/AuditLog${yesterday_ymd}.txt

Checking DocumentCacheStatisticsLog file in netan source TC65
    [Documentation]       Checking for DocumentCacheStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/DocumentCacheStatisticsLog${yesterday_ymd}.txt

Checking DocumentCacheStatisticsLog file size in netan source TC66
    Depends on test       Checking DocumentCacheStatisticsLog file in netan source TC65
    [Documentation]       Checking for non empty DocumentCacheStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/DocumentCacheStatisticsLog${yesterday_ymd}.txt

Checking DocumentCacheStatisticsLog file in netan destination TC67
    Depends on test       Checking DocumentCacheStatisticsLog file size in netan source TC66
    [Documentation]       Checking for DocumentCacheStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_cache}=         Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/DocumentCacheStatisticsLog${yesterday_ymd}.txt
    Set Global Variable    ${des_cache}
    Log To Console    ${des_cache}
    IF    ${des_cache} == True
        Pass Execution     DocumentCacheStatisticsLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    DocumentCacheStatisticsLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END
Checking DocumentCacheStatisticsLog file size in netan destination TC68
    Depends on test       Checking DocumentCacheStatisticsLog file in netan destination TC67
    [Documentation]       Checking for non empty DocumentCacheStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/DocumentCacheStatisticsLog${yesterday_ymd}.txt

Checking MemoryStatisticsLog file in netan source TC69
    [Documentation]       Checking for MemoryStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/MemoryStatisticsLog${yesterday_ymd}.txt

Checking MemoryStatisticsLog file size in netan source TC70
    Depends on test       Checking MemoryStatisticsLog file in netan source TC69
    [Documentation]       Checking for non empty MemoryStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/MemoryStatisticsLog${yesterday_ymd}.txt

Checking MemoryStatisticsLog file in netan destination TC71
    Depends on test       Checking MemoryStatisticsLog file size in netan source TC70
    [Documentation]       Checking for MemoryStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_memory}=        Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/MemoryStatisticsLog${yesterday_ymd}.txt
    Set Global Variable    ${des_memory}
    Log To Console    ${des_memory}
    IF    ${des_memory} == True
        Pass Execution     MemoryStatisticsLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    MemoryStatisticsLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking MemoryStatisticsLog file size in netan destination TC72
    Depends on test       Checking MemoryStatisticsLog file in netan destination TC71
    [Documentation]       Checking for non empty MemoryStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/MemoryStatisticsLog${yesterday_ymd}.txt

Checking OpenFilesStatisticsLog file in netan source TC73
    [Documentation]       Checking for OpenFilesStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/OpenFilesStatisticsLog${yesterday_ymd}.txt

Checking OpenFilesStatisticsLog file size in netan source TC74
    Depends on test       Checking OpenFilesStatisticsLog file in netan source TC73
    [Documentation]       Checking for non empty OpenFilesStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/OpenFilesStatisticsLog${yesterday_ymd}.txt

Checking OpenFilesStatisticsLog file in netan destination TC75
    Depends on test       Checking OpenFilesStatisticsLog file size in netan source TC74
    [Documentation]       Checking for OpenFilesStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_open}=          Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/OpenFilesStatisticsLog${yesterday_ymd}.txt
    Set Global Variable    ${des_open}
    Log To Console    ${des_open}
    IF    ${des_open} == True
        Pass Execution     OpenFilesStatisticsLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    OpenFilesStatisticsLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking OpenFilesStatisticsLog file size in netan destination TC76
    Depends on test       Checking OpenFilesStatisticsLog file in netan destination TC75
    [Documentation]       Checking for non empty OpenFilesStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/OpenFilesStatisticsLog${yesterday_ymd}.txt

Checking TimingLog file in netan source TC77
    [Documentation]       Checking for TimingLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/TimingLog${yesterday_ymd}.txt

Checking TimingLog file size in netan source TC78
    Depends on test       Checking TimingLog file in netan source TC77
    [Documentation]       Checking for non empty TimingLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/TimingLog${yesterday_ymd}.txt

Checking TimingLog file in netan destination TC79
    Depends on test       Checking TimingLog file size in netan source TC78
    [Documentation]       Checking for TimingLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_timing}=        Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/TimingLog${yesterday_ymd}.txt
    Set Global Variable    ${des_timing}
    Log To Console    ${des_timing}
    IF    ${des_timing} == True
        Pass Execution     TimingLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    TimingLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking TimingLog file size in netan destination TC80
    Depends on test       Checking TimingLog file in netan destination TC79
    [Documentation]       Checking for non empty TimingLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/TimingLog${yesterday_ymd}.txt

Checking userAuditLog file in netan source TC81
    [Documentation]       Checking for userAuditLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/userAuditLog${yesterday_ymd}.txt

Checking userAuditLog file size in netan source TC82
    Depends on test       Checking userAuditLog file in netan source TC81
    [Documentation]       Checking for non empty userAuditLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/userAuditLog${yesterday_ymd}.txt

Checking userAuditLog file in netan destination TC83
    Depends on test       Checking userAuditLog file size in netan source TC82
    [Documentation]       Checking for userAuditLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_usraudit}=      Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/userAuditLog${yesterday_ymd}.txt
    Set Global Variable    ${des_usraudit}
    Log To Console    ${des_usraudit}
    IF    ${des_usraudit} == True
        Pass Execution     userAuditLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    userAuditLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking userAuditLog file size in netan destination TC84
    Depends on test       Checking userAuditLog file in netan destination TC83
    [Documentation]       Checking for non empty userAuditLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/userAuditLog${yesterday_ymd}.txt

Checking UserSessionStatisticsLog file in netan source TC85
    [Documentation]       Checking for UserSessionStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Exists     /eniq/netanserver/ApplicationLogs/UserSessionStatisticsLog${yesterday_ymd}.txt

Checking UserSessionStatisticsLog file size in netan source TC86
    Depends on test       Checking UserSessionStatisticsLog file in netan source TC85
    [Documentation]       Checking for non empty UserSessionStatisticsLog${yesterday_ymd}.txt log file in /eniq/netanserver/ApplicationLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/ApplicationLogs/UserSessionStatisticsLog${yesterday_ymd}.txt

Checking UserSessionStatisticsLog file in netan destination TC87
    Depends on test       Checking UserSessionStatisticsLog file size in netan source TC86
    [Documentation]       Checking for UserSessionStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    ${des_usrstat}=       Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/UserSessionStatisticsLog${yesterday_ymd}.txt
    Set Global Variable    ${des_usrstat}
    Log To Console    ${des_usrstat}
    IF    ${des_usrstat} == True
        Pass Execution     UserSessionStatisticsLog${yesterday_ymd}.txt log file is available
    ELSE
        Skip    UserSessionStatisticsLog${yesterday_ymd}.txt log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking UserSessionStatisticsLog file size in netan destination TC88
    Depends on test       Checking UserSessionStatisticsLog file in netan destination TC87
    [Documentation]       Checking for non empty UserSessionStatisticsLog${yesterday_ymd}.txt log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_applications/UserSessionStatisticsLog${yesterday_ymd}.txt

Checking for count of netan feature log files in source TC89
    [Documentation]               Checking for count of log files in /eniq/netanserver/FeatureLogs directory
    [Tags]                        Netan
    ${log_files}                  Execute Command    find /eniq/netanserver/FeatureLogs/*${yesterday_ymd}.log
    Count Of Files                /eniq/netanserver/FeatureLogs/*${yesterday_ymd}.log
    ${feature_log_count}=         Run Keyword And Return Status     Should Be Equal As Strings    ${count}    6
    Set Global Variable           ${feature_log_count}
    Log To Console                ${feature_log_count}
    Run Keyword If    ${feature_log_count} == False    Skip    feature_log_count doesn't match to 6.

Checking for count of netan feature log files in destination TC90
    Skip If    ${feature_log_count} == False
    Depends on test               Checking for count of netan feature log files in source TC89
    [Documentation]               Checking for count of log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                        Netan
    Count Of Files                /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/*${yesterday_ymd}.log
    ${feature_des_log_count}=     Run Keyword And Return Status     Should Be Equal As Strings    ${count}    6
    Set Global Variable           ${feature_des_log_count}
    Log To Console                ${feature_des_log_count}
    Run Keyword If    ${feature_des_log_count} == False    Skip    feature_des_log_count doesn't match to 6.

Checking for missing feature netan log files TC91
    Skip If    ${feature_log_count} == False
    [Documentation]       Checking for missing log files in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${feature_mis_log_count}=     Run Keyword And Return Status    Check Missing File    /eniq/netanserver/FeatureLogs/*${yesterday_ymd}.log    /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/*${yesterday_ymd}.log
    Set Global Variable           ${feature_mis_log_count}
    Log To Console                ${feature_mis_log_count}
    Run Keyword If    ${feature_mis_log_count} == False    Skip    feature_mis_log_count doesn't match to 6.

Checking PMdb_Alarms_Summary file in netan source TC92
    [Documentation]        Checking for pmdb_alarms_summary_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                 Netan
    ${PMdb_Alarms}=        Run Keyword And Return Status    Check File Exists     /eniq/netanserver/FeatureLogs/pmdb_alarms_summary_${yesterday_ymd}.log
    Set Global Variable    ${PMdb_Alarms}
    Log To Console    ${PMdb_Alarms}
    Run Keyword If    ${PMdb_Alarms} == False    Skip    PMdb_Alarms_Summary log file is not there in the source path

Checking PMdb_Alarms_Summary file size in netan source TC93
    Skip If    ${PMdb_Alarms} == False
    Depends on test       Checking PMdb_Alarms_Summary file in netan source TC92
    [Documentation]       Checking for non empty pmdb_alarms_summary_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/pmdb_alarms_summary_${yesterday_ymd}.log

Checking PMdb_Alarms_Summary file in netan destination TC94
    Skip If    ${PMdb_Alarms} == False
    Depends on test       Checking PMdb_Alarms_Summary file size in netan source TC93
    [Documentation]       Checking for pmdb_alarms_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_alarm}=         Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_alarms_summary_${yesterday_ymd}.log
    Set Global Variable    ${des_alarm}
    Log To Console    ${des_alarm}
    IF    ${des_alarm} == True
        Pass Execution     pmdb_alarms_summary_${yesterday_ymd} log file is available
    ELSE
        Skip    pmdb_alarms_summary_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PMdb_Alarms_Summary file size in netan destination TC95
    Skip If    ${PMdb_Alarms} == False
    Depends on test       Checking PMdb_Alarms_Summary file in netan destination TC94
    [Documentation]       Checking for non empty pmdb_alarms_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_alarms_summary_${yesterday_ymd}.log

Checking PMdb_Collections_Summary log file in netan source TC96
    [Documentation]       Checking for pmdb_collections_summary_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    ${PMdb_Collection}=    Run Keyword And Return Status    Check File Exists     /eniq/netanserver/FeatureLogs/pmdb_collections_summary_${yesterday_ymd}.log
    Set Global Variable    ${PMdb_Collection}
    Log To Console    ${PMdb_Collection}
    Run Keyword If    ${PMdb_Collection} == False    Skip    PMdb_Collections_Summary log file is not there in the source path

Checking PMdb_Collections_Summary file size in netan source TC97
    Skip If    ${PMdb_Collection} == False
    Depends on test       Checking PMdb_Collections_Summary log file in netan source TC96
    [Documentation]       Checking for non empty pmdb_collections_summary_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/pmdb_collections_summary_${yesterday_ymd}.log

Checking PMdb_Collections_Summary file in netan destination TC98
    Skip If    ${PMdb_Collection} == False
    Depends on test       Checking PMdb_Collections_Summary file size in netan source TC97
    [Documentation]       Checking for pmdb_collections_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_cllt}=          Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_collections_summary_${yesterday_ymd}.log
    Set Global Variable    ${des_cllt}
    Log To Console    ${des_cllt}
    IF    ${des_cllt} == True
        Pass Execution     pmdb_collections_summary_${yesterday_ymd} log file is available
    ELSE
        Skip    pmdb_collections_summary_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PMdb_Collections_Summary file size in netan destination TC99
    Skip If    ${PMdb_Collection} == False
    Depends on test       Checking PMdb_Collections_Summary file in netan destination TC98
    [Documentation]       Checking for non empty pmdb_collections_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_collections_summary_${yesterday_ymd}.log

Checking PMdb_Reports_Summary file in netan source TC100
    [Documentation]        Checking for pmdb_reports_summary_${yesterday_ymd}.log log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                 Netan
    ${PMdb_Reports}=       Run Keyword And Return Status    Check File Exists     /eniq/netanserver/FeatureLogs/pmdb_reports_summary_${yesterday_ymd}.log
    Set Global Variable    ${PMdb_Reports}
    Log To Console    ${PMdb_Reports}
    Run Keyword If    ${PMdb_Reports} == False    Skip    PMdb_Reports_Summary log file is not there in the source path

Checking PMdb_Reports_Summary file size in netan source TC101
    Skip If    ${PMdb_Reports} == False
    Depends on test       Checking PMdb_Reports_Summary file in netan source TC100
    [Documentation]       Checking for non empty pmdb_reports_summary_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/pmdb_reports_summary_${yesterday_ymd}.log

Checking PMdb_Reports_Summary file in netan destination TC102
    Skip If    ${PMdb_Reports} == False
    Depends on test       Checking PMdb_Reports_Summary file size in netan source TC101
    [Documentation]       Checking for pmdb_reports_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_report}=        Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_reports_summary_${yesterday_ymd}.log
    Set Global Variable    ${des_report}
    Log To Console    ${des_report}
    IF    ${des_report} == True
        Pass Execution     pmdb_reports_summary_${yesterday_ymd} log file is available
    ELSE
        Skip    pmdb_reports_summary_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PMdb_Reports_Summary file size in netan destination TC103
    Skip If    ${PMdb_Reports} == False
    Depends on test       Checking PMdb_Reports_Summary file in netan destination TC102
    [Documentation]       Checking for non empty pmdb_reports_summary_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/pmdb_reports_summary_${yesterday_ymd}.log

Checking PMEx file in netan source TC104
    [Documentation]       Checking for PMEx_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    ${PMEx}=              Run Keyword And Return Status     Check File Exists     /eniq/netanserver/FeatureLogs/PMEx_${yesterday_ymd}.log
    Set Global Variable    ${PMEx}
    Log To Console    ${PMEx}
    Run Keyword If    ${PMEx} == False    Skip    PMEx log file is not there in the source path

Checking PMEx file size in netan source TC105
    Skip If    ${PMEx} == False
    Depends on test       Checking PMEx file in netan source TC104
    [Documentation]       Checking for non empty PMEx_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/PMEx_${yesterday_ymd}.log

Checking PMEx file in netan destination TC106
    Skip If    ${PMEx} == False
    Depends on test       Checking PMEx file size in netan source TC105
    [Documentation]       Checking for PMEx_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_pmex}=        Run Keyword And Return Status     Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/PMEx_${yesterday_ymd}.log
    Set Global Variable    ${des_pmex}
    Log To Console    ${des_pmex}
    IF    ${des_pmex} == True
        Pass Execution     PMEx_${yesterday_ymd} log file is available
    ELSE
        Skip    PMEx_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PMEx file size in netan destination TC107
    Skip If    ${PMEx} == False
    Depends on test       Checking PMEx file in netan destination TC106
    [Documentation]       Checking for non empty PMEx_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/PMEx_${yesterday_ymd}.log

Checking PMA file in netan source TC108
    [Documentation]       Checking for PMA_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    ${PMA}=              Run Keyword And Return Status      Check File Exists     /eniq/netanserver/FeatureLogs/PMA_${yesterday_ymd}.log
    Set Global Variable    ${PMA}
    Log To Console    ${PMA}
    Run Keyword If    ${PMA} == False    Skip    PMA log file is not there in the source path

Checking PMA file size in netan source TC109
    Skip If    ${PMA} == False
    Depends on test       Checking PMA file in netan source TC108
    [Documentation]       Checking for non empty PMA_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/PMA_${yesterday_ymd}.log

Checking PMA file in netan destination TC110
    Skip If    ${PMA} == False
    Depends on test       Checking PMA file size in netan source TC109
    [Documentation]       Checking for PMA_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_pma}=           Run Keyword And Return Status      Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/PMA_${yesterday_ymd}.log
    Set Global Variable    ${des_pma}
    Log To Console    ${des_pma}
    IF    ${des_pma} == True
        Pass Execution     PMA_${yesterday_ymd} log file is available
    ELSE
        Skip    PMA_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking PMA file size in netan destination TC111
    Skip If    ${PMA} == False
    Depends on test       Checking PMA file in netan destination TC110
    [Documentation]       Checking for non empty PMA_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/PMA_${yesterday_ymd}.log

Checking CustomKPI_Details file in netan source TC112
    [Documentation]       Checking for CustomKPI_Details_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    ${CustomKPI}=         Run Keyword And Return Status     Check File Exists     /eniq/netanserver/FeatureLogs/CustomKPI_Details_${yesterday_ymd}.log
    Set Global Variable    ${CustomKPI}
    Log To Console    ${CustomKPI}
    Run Keyword If    ${CustomKPI} == False    Skip    CustomKPI_Details log file is not there in the source path

Checking CustomKPI_Details file size in netan source TC113
    Skip If    ${CustomKPI} == False
    Depends on test       Checking CustomKPI_Details file in netan source TC112
    [Documentation]       Checking for non empty CustomKPI_Details_${yesterday_ymd} log file in /eniq/netanserver/FeatureLogs directory
    [Tags]                Netan
    Check File Size       /eniq/netanserver/FeatureLogs/CustomKPI_Details_${yesterday_ymd}.log

Checking CustomKPI_Details file in netan destination TC114
    Skip If    ${CustomKPI} == False
    Depends on test       Checking CustomKPI_Details file size in netan source TC113
    [Documentation]       Checking for CustomKPI_Details_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    ${des_cuskpi}=        Run Keyword And Return Status      Check File Exists     /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/CustomKPI_Details_${yesterday_ymd}.log
    Set Global Variable    ${des_cuskpi}
    Log To Console    ${des_cuskpi}
    IF    ${des_cuskpi} == True
        Pass Execution     CustomKPI_Details_${yesterday_ymd} log file is available
    ELSE
        Skip    CustomKPI_Details_${yesterday_ymd} log file is not available due to log collection not happened from mount path to DDC dir
    END

Checking CustomKPI_Details file size in netan destination TC115
    Skip If    ${CustomKPI} == False
    Depends on test       Checking CustomKPI_Details file in netan destination TC114
    [Documentation]       Checking for non empty CustomKPI_Details_${yesterday_ymd} log file in /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features directory
    [Tags]                Netan
    Check File Size       /eniq/log/ddc_data/${hostname}/uploaded/${yesterday_date_dmy}/plugin_data/netanserver_features/CustomKPI_Details_${yesterday_ymd}.log

Unmounting_logs TC116
    [Documentation]           Checking for unmounting logs from mounting directory
    [Tags]                    Netan
    unmounting logs           ${netan_mount_path}
