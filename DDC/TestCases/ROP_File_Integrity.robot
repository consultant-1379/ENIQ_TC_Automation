*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for engine file in ROP source TC01
    [Documentation]      Checking for engine-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               ROP_File_Integrity
    Check File Exists    /eniq/log/sw_log/engine/engine-${curr_date_Y_m_d}.log

Checking for engine file size in ROP source TC02
    Depends on test      Checking for engine file in ROP source TC01
    [Documentation]      Checking for non empty engine-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               ROP_File_Integrity
    Check File Size      /eniq/log/sw_log/engine/engine-${curr_date_Y_m_d}.log

Checking for engine file in ROP destination TC03
    Depends on test      Checking for engine file size in ROP source TC02
    [Documentation]      Checking for engine-${curr_date_Y_m_d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/backlog_monitoring directory
    [Tags]               ROP_File_Integrity
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/backlog_monitoring/engine-${curr_date_Y_m_d}.log

Checking for engine file size in ROP destination TC04
    Depends on test      Checking for engine file in ROP destination TC03
    [Documentation]      Checking for non empty engine-${curr_date_Y_m_d}.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/backlog_monitoring directory
    [Tags]               ROP_File_Integrity
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/backlog_monitoring/engine-${curr_date_Y_m_d}.log
