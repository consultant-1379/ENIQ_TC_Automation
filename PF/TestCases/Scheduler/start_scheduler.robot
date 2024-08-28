*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup    Open connection as root user
Test Teardown    Close All Connections
 
 
*** Test Cases ***
Verify start scheduler and logs
    Write    su - dcuser
    Read    delay=1s
    Write     cd /eniq/sw/installer ; scheduler start
    ${hold_scheduler}    Read  
    ${check_status}    Set Variable    scheduler status
    ${msg}    Set Variable    scheduler is running OK
    ${start}    Run Keyword And Return Status    Iterating for 3 minutes    ${check_status}    ${msg}    
    IF    '${start}' == 'True'
        Verify the scheduler logs when we start scheduler
    ELSE
        Fail
    END
   
   
*** Keywords ***    
Iterating for 3 minutes 
    [Arguments]    ${check_status}    ${msg}    
    ${date}    Execute Command    date +"%H:%M"
    ${date_3minutes}    Execute Command    date -d "3 minutes" +'%H:%M'
    FOR    ${counter}    IN RANGE    0    6    1
        IF    '${date}' <= '${date_3minutes}'
            Write    ${check_status}
            ${check_status}    Read    delay=50s
            Log    ${check_status}
            ${status}    Run Keyword And Return Status    Should Contain    ${check_status}    ${msg}  
            ${date}    Execute Command    date +"%H:%M"
            IF    '${status}' == 'True'
                RETURN    True
            ELSE
                Continue For Loop
            END
        ELSE
            Fail    
        END
    END
 
Verify the scheduler logs when we start scheduler
    ${date}    Execute command     date "+%y%m%d"
    ${scheduler_file}    Execute Command    cd /eniq/log/sw_log/scheduler && ls | grep start_scheduler_${date} | tail -1
    ${output}   ${rc}=      Execute Command     cd /eniq/log/sw_log/scheduler && grep -i -E 'exception|error|server not found' ./${scheduler_file}      return_rc=True
    ${output_length}    Get Length    ${output}
    IF   '${rc}' == '1' and '${output_length}' == '0'
         Log To Console    "scheduler is running"
    ELSE
         Fail    ${output}
    END        