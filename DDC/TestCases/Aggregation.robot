*** Settings ***
Suite Setup        Open Connection And Log In
Suite Teardown     Close All Connections
Library            SSHLibrary
Library            DateTime
Library            DependencyLibrary
Resource           ../Resources/Resource.resource


*** Test Cases ***
Checking for statsAggregatorSession file in ENIQ directory TC01
    [Documentation]        Checking for statsAggregatorSession.log in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Aggregation
    Check File Exists      /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAggregatorSession.log

Checking for statsAggregatorSession file size in ENIQ directory TC02
    Depends on test        Checking for statsAggregatorSession file in ENIQ directory TC01
    [Documentation]        Checking for non empty statsAggregatorSession.log file in /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ directory
    [Tags]                 Aggregation
    Check File Size        /eniq/log/ddc_data/${hostname}/${date_dmy}/ENIQ/statsAggregatorSession.log
