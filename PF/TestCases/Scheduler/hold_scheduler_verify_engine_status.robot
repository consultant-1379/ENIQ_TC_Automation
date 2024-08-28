*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections


*** Test Cases ***
Verify hold scheduler and engine
    Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#   timeout=60s
    Write    su - dcuser
    Read    delay=1s    
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler hold
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine status
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler is activated
    
*** Keywords ***    
check scheduler hold
    Write    scheduler hold
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Hold successfully requested

check engine status
    Write    engine status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     engine is running OK

check scheduler is activated
    Write    scheduler activate
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     scheduler is running OK
           