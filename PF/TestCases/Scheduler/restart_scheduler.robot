*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Scheduler.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
Verify scheduler restart
    Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#   timeout=60s
    Write    su - dcuser
    Read    delay=1s    
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler restart
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Verify the stop_scheduler logs when we stop scheduler
    Verify the start_scheduler logs when we start scheduler

    
*** Keywords ***    
check scheduler restart
    Write    scheduler restart
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service enabling eniq-scheduler

check scheduler status
    Write    scheduler status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     scheduler is running OK
