*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    test teardown steps

*** Test Cases ***
Verify scheduler status should be active when engine is down
    Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#   timeout=60s
    Write    ssh engine
    Read    delay=1s
    Write    sudo su - dcuser
    Read    delay=1s  
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine stop
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine status
    Write    exit
    Read    delay=1s
    Write    sudo su - dcuser
    Read    delay=1s
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Write    ssh engine
    Read    delay=1s
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine start

*** keywords ***
check engine stop
    Write    engine stop
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}    Service stopping eniq-engine

check engine status
    Write    engine status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}    engine is not running

check scheduler status
    Write    scheduler status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     scheduler is running OK

check engine start
    Write    engine start
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}    Service enabling eniq-engine

test teardown steps
    ${check_engine}    Run Keyword And Return Status   Wait Until Keyword Succeeds    3x    2s    check scheduler status
    IF    '${check_engine}' == 'False'
        ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler restart
    END
    ${check_engine}    Run Keyword And Return Status   Wait Until Keyword Succeeds    3x    2s    check engine status when active
    IF    '${check_engine}' == 'False'
        ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine start
    END

check scheduler restart
    Write    exit
    Read    delay=1s
    Write    sudo su - dcuser
    Read    delay=1s  
    Write    scheduler restart
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service enabling eniq-scheduler

check engine status when active
    Write    ssh engine
    Read    delay=1s
    Write    engine status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}    engine is running OK
