*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Verify stop scheduler and logs
    Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#   timeout=60s
    Write    sudo su - dcuser
    Read    delay=1s    
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler stop
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Verify the scheduler logs when we stop scheduler
    
*** Keywords ***    
check scheduler stop
    Write    scheduler stop
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service stopping eniq-scheduler

check scheduler status
    Write    scheduler status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     scheduler is not running

Verify the scheduler logs when we stop scheduler 
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep stop_scheduler_${date} | tail -1
    ${output}   ${rc}=      Execute Command     cd /eniq/log/sw_log/scheduler && grep -i -E 'exception|error|server not found' ./${scheduler_file}      return_rc=True
    ${output_length}    Get Length    ${output}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "scheduler is running"
    ELSE
         Fail    ${output}
    END        

