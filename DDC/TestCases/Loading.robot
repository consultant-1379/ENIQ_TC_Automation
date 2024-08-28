*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for statsLoaderSession file in ENIQ directory TC01
    [Documentation]        Checking for statsLoaderSession.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Loading
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsLoaderSession.log

Checking for statsLoaderSession file size in ENIQ directory TC02
    Depends on test        Checking for statsLoaderSession file in ENIQ directory TC01
    [Documentation]        Checking for non empty statsLoaderSession.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Loading
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsLoaderSession.log
