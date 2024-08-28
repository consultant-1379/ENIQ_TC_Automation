*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Open connection as root user
Suite Teardown   Close All Connections

*** Test Cases ***
Check Scheduler dir is present
    ${check_sch_dir}=    Execute Command    ls -lrth /eniq/log/sw_log/ | grep -i "\\bscheduler\\b"
    ${sch_dir_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_sch_dir} 
    Set Suite Variable    ${check_sch_dir}
    Set Suite Variable    ${sch_dir_status}
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present

Check Scheduler dir user and permissions
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    Should Match Regexp   ${check_sch_dir}    ^drwxr-x---[^a-zA-Z]+dcuser\\b

Check Scheduler start log is present     
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    ${check_startfile}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "start_scheduler" | tail -1
    Log   ${check_startfile}
    ${check_startfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_startfile}
    Log    ${check_startfile_status}
    Set Suite Variable    ${check_startfile_status}
    Set Suite Variable    ${check_startfile}
    Skip If    ${check_startfile_status} == False    msg=Start scheduler file not present

Check Scheduler start log user and permissions   
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present  
    Skip If    ${check_startfile_status} == False    msg=Start scheduler file not present
    Should Match Regexp    ${check_startfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check Scheduler start log for any exceptions     
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    Skip If    ${check_startfile_status} == False    msg=Start scheduler file not present
    ${start_sch}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "start_scheduler" | tail -1
    Log    ${start_sch}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${start_sch}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/scheduler/${start_sch} | grep -i "running OK"
        Should Contain    ${check_file}    running OK  
    ELSE
        Skip    Start scheduler file not present
    END

Check Scheduler stop log is present   
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present  
    ${check_stopfile}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "stop_scheduler" | tail -1
    Log   ${check_stopfile}
    ${check_stopfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stopfile}
    Log    ${check_stopfile_status}
    Set Suite Variable    ${check_stopfile_status}
    Set Suite Variable    ${check_stopfile}
    Skip If    ${check_stopfile_status} == False    msg=Stop scheduler file not present

Check Scheduler stop log user and permissions  
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present   
    Skip If    ${check_stopfile_status} == False    msg=Stop scheduler file not present
    Should Match Regexp    ${check_stopfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check Scheduler stop log for any exceptions  
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present   
    Skip If    ${check_stopfile_status} == False    msg=Stop scheduler file not present
    ${stop}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "stop_scheduler" | tail -1
    Log    ${stop}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${stop}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/scheduler/${stop} | grep -i "shutdown is complete"
        Should Contain    ${check_file}    shutdown is complete
    ELSE
        Skip    stop scheduler file not present
    END

Check Schedulerheap log is present    
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    ${ct_scheap_date}=    Execute Command    date +"%Y-%m-%d"
    ${check_scheapfile}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "schedulerHeap-${ct_scheap_date}"
    Log   ${check_scheapfile}
    ${check_scheapfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_scheapfile}
    Log    ${check_scheapfile_status}
    Set Suite Variable    ${check_scheapfile_status}
    Set Suite Variable    ${check_scheapfile}
    Skip If    ${check_scheapfile_status} == False    msg=schedulerHeap file not present

Check Schedulerheap log user and permissions  
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present  
    Skip If    ${check_scheapfile_status} == False     msg=schedulerHeap file not present
    Should Match Regexp    ${check_scheapfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check Schedulerheap log for any exceptions   
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present 
    Skip If    ${check_scheapfile_status} == False    msg=schedulerHeap file not present
    ${ct_scheap_date}=    Execute Command    date +"%Y-%m-%d"
    ${scheap_file}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "schedulerHeap-${ct_scheap_date}"
    Log   ${scheap_file}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${scheap_file}
    Log    ${file_status}
    IF    ${file_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/scheduler/${scheap_file} | grep -i "exception\\|warning\\|severe\\|failed\\|error"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    schedulerHeap file not present
    END

Check Scheduler log is present    
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    ${ct_scheduler_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_schedulerfile}=    Execute Command    ls -lrth /eniq/log/sw_log/scheduler | grep -i "scheduler-${ct_scheduler_date}" | tail -1
    Log   ${check_schedulerfile}
    ${check_schfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_schedulerfile}
    Log    ${check_schfile_status}
    Set Suite Variable    ${check_schfile_status}
    Set Suite Variable    ${check_schedulerfile}
    Skip If    ${check_schfile_status} == False    msg=scheduler log file not present

Check Scheduler log user and permissions   
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present 
    Skip If    ${check_schfile_status} == False    msg=scheduler log file not present
    Should Match Regexp    ${check_schedulerfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check Scheduler log for any exceptions    
    Skip If    ${sch_dir_status} == False    msg=scheduler dir not present
    Skip If    ${check_schfile_status} == False    msg=scheduler log file not present
    ${ct_scheduler_date}=    Execute Command    date +"%Y_%m_%d"
    ${sch_file}=    Execute Command    ls -Art /eniq/log/sw_log/scheduler | grep -i "scheduler-${ct_scheduler_date}"
    Log   ${sch_file}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${sch_file}
    Log    ${file_status}
    IF    ${file_status} == True
        ${check_sch_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/scheduler/${sch_file} | grep -i "exception\\|severe\\|failed\\|error"    return_stderr=True
        Should Be Empty    ${stderr}  
        Should Be Empty    ${check_sch_logs}
    ELSE
        Skip    scheduler file not present
    END

       