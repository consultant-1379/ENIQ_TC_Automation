*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections

*** Test Cases ***
check sceduler stop log is present
    ${latest_stop}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "stop_scheduler" | tail -1
    Log   ${latest_stop}
    ${latest_file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_stop}
    Log    ${latest_file_status}
    Set Suite Variable    ${latest_file_status}
    Set Suite Variable    ${latest_stop}
    Skip If    ${latest_file_status} == False    msg=Stop scheduler file not present

check sceduler stop log user and permissions
    Skip If    ${latest_file_status} == False    msg=Stop scheduler file not present
    Should Match Regexp    ${latest_stop}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check sceduler stop log for any exceptions
    Skip If    ${latest_file_status} == False    msg=Stop scheduler file not present
    ${stop}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "stop_scheduler" | tail -1
    Log    ${stop}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${stop}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/scheduler/${stop} | grep -i "shutdown is complete"
        Should Contain    ${check_file}    shutdown is complete
    ELSE
        Skip    stop scheduler file not present
    END

check sceduler start log is present
    ${latest_start_sch}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "start_scheduler" | tail -1
    Log   ${latest_start_sch}
    ${latest_file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${latest_start_sch}
    Log    ${latest_file_status}
    Set Suite Variable    ${latest_file_status}
    Set Suite Variable    ${latest_start_sch}
    Skip If    ${latest_file_status} == False    msg=Start scheduler file not present

check sceduler start log user and permissions
    Skip If    ${latest_file_status} == False    msg=Start scheduler file not present
    Should Match Regexp    ${latest_start_sch}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check sceduler start log for any exceptions
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