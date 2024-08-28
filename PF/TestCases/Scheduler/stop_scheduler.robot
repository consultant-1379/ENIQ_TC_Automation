*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Scheduler.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections



*** Test Cases ***
Verify the scheduler logs when we stop scheduler
    Write    su - dcuser
    Read    delay=1s
    Write     cd /eniq/sw/installer ; scheduler stop
    ${hold_scheduler}    Read
    ${msg_hold}    Set Variable    scheduler is not running
    ${check_scheduler}    Set Variable    scheduler status
    ${hold}    Run Keyword And Return Status    Iterating for 3 minutes    ${check_scheduler}    ${msg_hold}    
    IF    '${hold}' == 'True'
        ${engine}    Set Variable    engine status
        ${msg_active}    Set Variable    Status: active 
        ${engine_active}    Run Keyword And Return Status    Iterating for 3 minutes    ${engine}    ${msg_active}
    ELSE
        Fail
    END
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep stop_scheduler_${date} | tail -1
    ${output}   ${rc}=      Execute Command     cd /eniq/log/sw_log/scheduler && grep -i -E 'exception|error|server not found' ./${scheduler_file}      return_rc=True
    ${output_length}    Get Length    ${output}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "scheduler is running"
    ELSE
         Fail    ${output}
    END        

Verify engine logs & check for parsing when scheduler goes down
    Write    su - dcuser
    ${output}=    Read    delay=1s
    ${date}    Execute Command     date '+%Y_%m_%d'
    Write    cd /eniq/log/sw_log/engine && d=$(date '+%H:%M:%S') && cat engine-${date}.log | grep -i $d | grep -i -E 'parsed\|loaded'
    ${stop_scheduler_status}    Read    delay=2s
    ${length_scheduler_status}    Get Length    ${stop_scheduler_status}
    IF    ${length_scheduler_status} != 0
        Fail    Parsing is not stopped when scheduler is down
    END