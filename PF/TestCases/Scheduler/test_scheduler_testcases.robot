*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Scheduler.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections


*** Test Cases ***
Verify start scheduler
    ${latest_start_sch}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "start_scheduler" | tail -1
    Log   ${latest_start_sch}
    ${latest_file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_start_sch}
    Log    ${latest_file_status}
    Set Suite Variable    ${latest_file_status}
    Set Suite Variable    ${latest_start_sch}
    Skip If    ${latest_file_status} == False    msg=Start scheduler file not present


Verify persmission
    Skip If    ${latest_file_status} == False    msg=Start scheduler file not present
    Should Match Regexp    ${latest_start_sch}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Verify file log
    Skip If    ${latest_file_status} == False    msg=Start scheduler file not present
    ${start_sch}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "start_scheduler" | tail -1
    Log    ${start_sch}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${start_sch}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/scheduler/${start_sch} | grep -i "running OK"
        Should Contain    ${check_file}    running OK  
    ELSE
        Skip    Start scheduler file not present
    END