*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Scheduler.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Test Teardown steps

*** Test Cases ***
Verify scheduler status should be active when engine is down
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Write     cd /eniq/sw/installer ; engine stop
    ${hold_scheduler}    Read
    ${msg_hold}    Set Variable    engine is not running
    ${check_scheduler}    Set Variable    engine status
    ${hold}    Run Keyword And Return Status    Iterating for 3 minutes    ${check_scheduler}    ${msg_hold}    
    IF    '${hold}' == 'True'
        ${engine}    Set Variable    scheduler status    
        ${msg_active}    Set Variable    scheduler is running OK
        ${engine_active}    Run Keyword And Return Status    Iterating for 3 minutes    ${engine}    ${msg_active}          
    ELSE
        Fail
    END

*** keywords ***
Test Teardown steps
    Write    engine start
    Read    delay=5s
    Close All Connections
