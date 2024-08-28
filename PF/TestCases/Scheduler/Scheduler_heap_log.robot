*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections

*** Test Cases ***
check schedulerheap log is present
    ${ct_scheap_date}=    Execute Command    date +"%Y-%m-%d"
    ${lt_scheapfile}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "schedulerHeap-${ct_scheap_date}"
    Log   ${lt_scheapfile}
    ${lt_scheapfile_st}=    Run Keyword And Return Status    Should Not Be Empty    ${lt_scheapfile}
    Log    ${lt_scheapfile_st}
    Set Suite Variable    ${lt_scheapfile_st}
    Set Suite Variable    ${lt_scheapfile}
    Skip If    ${lt_scheapfile_st} == False    msg=schedulerHeap file not present

check schedulerheap log user and permissions
    Skip If    ${lt_scheapfile_st} == False    msg=schedulerHeap file not present
    Should Match Regexp    ${lt_scheapfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check scedulerheap log for any exceptions
    Skip If    ${lt_scheapfile_st} == False    msg=schedulerHeap file not present
    ${ct_scheap_date}=    Execute Command    date +"%Y-%m-%d"
    ${lt_scheapfile}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "schedulerHeap-${ct_scheap_date}"
    Log   ${lt_scheapfile}
    ${lt_scheapfile_st}=    Run Keyword And Return Status    Should Not Be Empty    ${lt_scheapfile}
    Log    ${lt_scheapfile_st}
    IF    ${lt_scheapfile_st} == True
        ${scheap_data}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/scheduler/${lt_scheapfile}
        ${check_scheap_log}=    Run Keyword And Return Status    Should Not Be Empty    ${scheap_data}
        IF    ${check_scheap_log} == True
            ${scheap_log_errors}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/scheduler/${lt_scheapfile} | grep -i "exception\\|warning\\|severe\\|failed\\|error"
            Should Be Empty     ${scheap_log_errors}
        ELSE
            Log To Console    file data not found
        END
    ELSE
        Skip    schedulerHeap file not present
    END

check sceduler log is present
    ${scheduler_log}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "scheduler-" | tail -1
    Log   ${scheduler_log}
    ${latest_file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${scheduler_log}
    Log    ${latest_file_status}
    Set Suite Variable    ${latest_file_status}
    Set Suite Variable    ${scheduler_log}
    Skip If    ${latest_file_status} == False    msg=scheduler log file not present

check sceduler log user and permissions
    Skip If    ${latest_file_status} == False    msg=scheduler log file not present
    Should Match Regexp    ${scheduler_log}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check sceduler log for any exceptions
    Skip If    ${latest_file_status} == False    msg=scheduler log file not present
    ${ct_scheduler_date}=    Execute Command    date +"%Y_%m_%d"
    ${lt_schedulerfile}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "scheduler-${ct_scheduler_date}"
    Log   ${lt_schedulerfile}
    ${lt_schedulerfile_st}=    Run Keyword And Return Status    Should Not Be Empty    ${lt_schedulerfile}
    Log    ${lt_schedulerfile_st}
    IF    ${lt_schedulerfile_st} == True
        ${scheaduler_data}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/scheduler/${lt_schedulerfile}
        ${check_scheduler_log}=    Run Keyword And Return Status    Should Not Be Empty    ${scheaduler_data}
        IF    ${check_scheduler_log} == True
            ${scheduler_log_errors}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/scheduler/${lt_schedulerfile} | grep -i "exception\\|severe\\|failed\\|error"
            Should Be Empty     ${scheduler_log_errors}
        ELSE
            Log To Console    file data not found
        END
    ELSE
        Skip    scheduler file not present
    END