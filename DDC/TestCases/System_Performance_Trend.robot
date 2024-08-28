*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for sar.incr file in System Performance Trend TC01
    [Documentation]        Checking for sar.incr file in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                 System_Performance_Trend
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr

Checking for sar.incr file size in System Performance Trend TC02
    Depends on test        Checking for sar.incr file in System Performance Trend TC01
    [Documentation]        Checking for non empty file in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                 System_Performance_Trend
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr

Checking for sar_incr file in System Performance Trend TC03
    Depends on test        Checking for sar.incr file size in System Performance Trend TC02
    [Documentation]        Checking for ${sar_incr} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                 System_Performance_Trend
    ${sar_incr}=           Execute Command    cat /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.incr | cut -d "@" -f 1
    Set Global Variable    ${sar_incr}
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.${sar_incr}

Checking for sar_incr file size in System Performance Trend TC04
    Depends on test        Checking for sar_incr file in System Performance Trend TC03
    [Documentation]        Checking for non empty ${sar_incr} file in /eniq/log/ddc_data/${hostname}/${date_dmy}/server directory
    [Tags]                 System_Performance_Trend
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/server/sar.${sar_incr}
