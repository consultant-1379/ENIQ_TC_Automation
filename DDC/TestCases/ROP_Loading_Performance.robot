*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for duration file in ROP Loading Performance TC01
    [Documentation]      Checking for duration.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]               ROP_Loading_Performance
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/duration.log

Checking for duration file size in ROP Loading Performance TC02
    Depends on test      Checking for duration file in ROP Loading Performance TC01
    [Documentation]      Checking for duration.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]               ROP_Loading_Performance
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/duration.log
