*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Scheduler.robot
Suite Setup    suite setup for scheduler
Suite Teardown     Close All Connections

*** Test Cases ***
Stop_scheduler
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler stop
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Should Contain    ${check_scheduler}    scheduler is not running
    Verify the scheduler logs when we stop scheduler

Stop_scheduler_check_engine_status
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine status
    Should Contain    ${check_engine}    engine is running OK
    
Start_scheduler
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler start
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Should Contain    ${check_scheduler}    scheduler is running OK
    Verify the scheduler logs when we start scheduler

Restart_scheduler
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler restart
    ${check_status}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    ${status}    Run Keyword And Return Status    Should Contain    ${check_status}    scheduler is running OK
    Set Suite Variable    ${status}
    Verify the stop_scheduler logs when we stop scheduler
    Verify the start_scheduler logs when we start scheduler

Hold_scheduler_scheduler_status
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    Skip If    ${status} == False    msg=Restart scheduler not happened
    ${check_hold}=    Wait Until Keyword Succeeds    3x    2s    check scheduler hold
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status
    Should Contain    ${check_scheduler}    scheduler is running OK
    

Verify hold scheduler and engine
    Skip If    ${engine} == False    msg=engine is not running before running scheduler tc
    Skip If    ${scheduler} == False    msg=scheduler is not running before running scheduler tc
    Skip If    ${status} == False    msg=Restart scheduler not happened
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine status
    Should Contain    ${check_engine}    engine is running OK
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check scheduler is activated

*** Keywords ***
check engine stop
    Write    engine stop
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}    Service stopping eniq-engine

check scheduler hold
    Write    scheduler hold
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Hold successfully requested

check scheduler is activated
    Write    scheduler activate
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     scheduler is running OK

check scheduler restart
    Write    scheduler restart
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service enabling eniq-scheduler

check scheduler status
    Write    scheduler status
    ${check_scheduler}=    Read Until Prompt    strip_prompt=True
    RETURN    ${check_scheduler}

check engine status
    Write    engine status
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    RETURN    ${check_engine}

check scheduler stop
    Write    scheduler stop
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service stopping eniq-scheduler

check scheduler start
    Write    scheduler start
    ${check_engine}=    Read Until Prompt    strip_prompt=True      
    Should Contain    ${check_engine}     Service enabling eniq-scheduler

Verify the scheduler logs when we stop scheduler
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep stop_scheduler_${date} | tail -1
    Log   ${scheduler_file}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${scheduler_file}
    Log    ${file_status}
    IF    ${file_status} == True
        ${output}   ${stderr}=    Execute Command     cat /eniq/log/sw_log/scheduler/${scheduler_file} | grep -i "exception\\|severe\\|failed\\|error"    return_stderr=True 
        Should Be Empty    ${stderr}  
        Should Be Empty    ${output}  
    ELSE
        Skip    scheduler stop file not present
    END      

Verify the scheduler logs when we start scheduler
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep start_scheduler_${date} | tail -1
     Log   ${scheduler_file}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${scheduler_file}
    Log    ${file_status}
    IF    ${file_status} == True
        ${output}   ${stderr}=      Execute Command     cat /eniq/log/sw_log/scheduler/${scheduler_file} | grep -i "exception\\|severe\\|failed\\|error"    return_stderr=True 
        Should Be Empty    ${stderr}  
        Should Be Empty    ${output}  
    ELSE
        Skip    scheduler start file not present
    END     

suite setup for scheduler
    Open connection as root user
    Set Client Configuration    prompt=REGEXP:\\bieatrcx\\S+\\[\\S+\\]\\s{\\w+}\\s#   timeout=60s
    Write    su - dcuser
    Read    delay=1s  
    ${check_engine}=    Wait Until Keyword Succeeds    3x    2s    check engine status     
    ${engine}    Run Keyword And Return Status    Should Contain    ${check_engine}    engine is running OK
    Set Suite Variable    ${engine}
    ${check_scheduler}=    Wait Until Keyword Succeeds    3x    2s    check scheduler status    
    ${scheduler}    Run Keyword And Return Status    Should Contain    ${check_scheduler}     scheduler is running OK
    Set Suite Variable    ${scheduler}