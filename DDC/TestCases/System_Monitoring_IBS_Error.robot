*** Settings ***
Test Setup        Open Connection And Log In
Test Teardown     Close All Connections
Library           SSHLibrary
Library           DateTime
Library           DependencyLibrary
Resource          ../Resources/Resource.resource


*** Test Cases ***
Checking for sqlerror file in IBS source
    [Documentation]      Checking for sqlerror-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Exists    /eniq/log/sw_log/engine/sqlerror-${curr_date_Y_m_d}.log

Checking for sqlerror file size in IBS source
    Depends on test      Checking for sqlerror file in IBS source
    [Documentation]      Checking for non empty sqlerror-${curr_date_Y_m_d}.log file in /eniq/log/sw_log/engine directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Size      /eniq/log/sw_log/engine/sqlerror-${curr_date_Y_m_d}.log

Checking for IBSErrorLoaderSet file in IBS source
    [Documentation]      Checking for IBSErrorLoaderSet_${date_Y-m-d}.txt file in /eniq/log/assureddc/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Exists    /eniq/log/assureddc/loaderAggregatorSetFailure/IBSErrorLoaderSet_${date_Y-m-d}.txt

Checking for IBSErrorLoaderSet file size in IBS source
    Depends on test      Checking for IBSErrorLoaderSet file in IBS source
    [Documentation]      Checking for non empty IBSErrorLoaderSet_${date_Y-m-d}.txt file in /eniq/log/assureddc/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Size      /eniq/log/assureddc/loaderAggregatorSetFailure/IBSErrorLoaderSet_${date_Y-m-d}.txt

Checking for IBSErrorLoaderSet file in IBS destination
    Depends on test      Checking for IBSErrorLoaderSet file size in IBS source
    [Documentation]      Checking for IBSErrorLoaderSet_${date_Y-m-d}.txt in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Exists    /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/IBSErrorLoaderSet_${date_Y-m-d}.txt

Checking for IBSErrorLoaderSet file size in IBS destination
    Depends on test      Checking for IBSErrorLoaderSet file in IBS destination
    [Documentation]      Checking for non empty IBSErrorLoaderSet_${date_Y-m-d}.txt file in /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure directory
    [Tags]               System_Monitoring_IBS_Error
    Check File Size      /eniq/log/ddc_data/${hostname}/${date_dmy}/plugin_data/loaderAggregatorSetFailure/IBSErrorLoaderSet_${date_Y-m-d}.txt
