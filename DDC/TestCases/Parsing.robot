*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for statsAdapterSession file in ENIQ directory TC01
    [Documentation]        Checking for statsAdapterSession.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Parsing
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAdapterSession.log

Checking for statsAdapterSession file size in ENIQ directory TC02
    Depends on test        Checking for statsAdapterSession file in ENIQ directory TC01
    [Documentation]        Checking for non empty statsAdapterSession.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Parsing
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAdapterSession.log

Checking for statsAdapterTotals file in ENIQ directory TC03
    [Documentation]        Checking for statsAdapterTotals.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Parsing
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAdapterTotals.log

Checking for statsAdapterTotals file size in ENIQ directory TC04
    Depends on test        Checking for statsAdapterTotals file in ENIQ directory TC03
    [Documentation]        Checking for non empty statsAdapterTotals.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Parsing
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAdapterTotals.log
