*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for hwmonitor_monitor file in FC source TC01
    [Documentation]        Checking for hwmonitor_monitor_${date_ymd}_0.log file in /var/log/hwcomm/ directory
    [Tags]                 fc_switch_port_alarm
    ${ports}=     Run Keyword And Return Status    Check File Exists      /var/log/hwcomm/hwmonitor_monitor_${date_ymd}_0.log
    Set Global Variable    ${ports}
    Log To Console    ${ports}
    Run Keyword If    ${ports} == False    Skip    Ports are not enabled in the server
    IF    ${ports} == True
    ${src_file_size}=    Check File Size New      /var/log/hwcomm/hwmonitor_monitor_${date_ymd}_0.log
    Set Global Variable    ${src_file_size}
    Run Keyword If   ${src_file_size}==0   Fail    Size is zero.
    ELSE
        Skip   Ports are not enabled in the server
    END

Checking for hwmonitor_monitor file in FC destination TC02
    Skip If    ${ports} == False
    Depends on test        Checking for hwmonitor_monitor file size in FC source TC01
    [Documentation]        Checking for hwmonitor_monitor_${date_ymd}_0.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/fc_switch_port_alarm directory
    [Tags]                 fc_switch_port_alarm
    ${des_ports}=     Run Keyword And Return Status    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_ymd}/plugin_data/fc_switch_port_alarm/hwmonitor_monitor_${date_dmy}_0.log
    Set Global Variable    ${des_ports}
    Log To Console    ${des_ports}
    Run Keyword If    ${des_ports} == False    Skip    Ports are not enabled in the server
    IF    ${des_ports} == True
    ${src_file_size}=    Check File Size New      /eniq/log/ddc_data/${hostname}/${date_ymd}/plugin_data/fc_switch_port_alarm/hwmonitor_monitor_${date_dmy}_0.log
    Set Global Variable    ${src_file_size}
    Run Keyword If   ${src_file_size}==0   Fail    Size is zero.
    ELSE
        Fail   Ports are not enabled in the server
    END
