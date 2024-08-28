*** Settings ***
Library    SSHLibrary
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections

*** Test Cases ***

Verify scheduler and engine services when license is not expired
    ${licmgr_status}=    Execute Command    /eniq/sw/bin/licmgr -status
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK

    ${eniq_engine_status}=    Execute Command    /eniq/sw/bin/engine status
    Log To Console    ${eniq_engine_status}
    Verify command output    ${eniq_engine_status}    Status: active
    Verify command output    ${eniq_engine_status}    cache status : initialized
    Verify command output    ${eniq_engine_status}    Current Profile: Normal
    Verify command output    ${eniq_engine_status}    engine is running OK
    Verify command output    ${eniq_engine_status}    lwp helper is running

    ${eniq_scheduler_status}=    Execute Command    /eniq/sw/bin/scheduler status
    Log To Console    ${eniq_scheduler_status}
    Verify command output    ${eniq_scheduler_status}    Status: active