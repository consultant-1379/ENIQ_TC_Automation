*** Settings ***
Library    SSHLibrary
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot
Suite Setup    Open connection as root user
Suite Teardown    Close All Connections

*** Test Cases ***

Verify scheduler and engine services when license is not expired
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Write    /eniq/sw/bin/licmgr -status
    ${licmgr_status}=    Read    delay=2s
    Log To Console     ${licmgr_status}
    Verify command output    ${licmgr_status}    License manager is running OK

    Write    /eniq/sw/bin/engine status
    ${eniq_engine_status}=    Read    delay=2s
    Log To Console    ${eniq_engine_status}
    Verify command output    ${eniq_engine_status}    Status: active
    Verify command output    ${eniq_engine_status}    cache status : initialized
    Verify command output    ${eniq_engine_status}    Current Profile: Normal
    Verify command output    ${eniq_engine_status}    engine is running OK
    Verify command output    ${eniq_engine_status}    lwp helper is running

    Write    /eniq/sw/bin/scheduler status
    ${eniq_scheduler_status}=    Read    delay=2s   
    Log To Console    ${eniq_scheduler_status}
    Verify command output    ${eniq_scheduler_status}    Status: active