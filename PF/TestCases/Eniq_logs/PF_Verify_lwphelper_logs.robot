*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite Setup   Suite setup steps for scheduler
Suite Teardown   Close All Connections

*** Test Cases ***
Check lwphelper dir user and permissions    
    Should Match Regexp   ${check_lwp_dir}    ^drwxr-x---[^a-zA-Z]+dcuser\\b

Check lwphelper start log is present         
    ${check_startfile}=    Execute Command    ls -lrth /eniq/log/sw_log/engine/lwphelper | grep -i "\\\bstart_lwph_" | tail -1
    Log   ${check_startfile}
    ${check_startfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_startfile}
    Log    ${check_startfile_status}
    Set Suite Variable    ${check_startfile_status}
    Set Suite Variable    ${check_startfile}
    Skip If    ${check_startfile_status} == False    msg=Start lwphelper not present

Check lwphelper start log user and permissions         
    Skip If    ${check_startfile_status} == False    msg=Start lwphelper not present
    Should Match Regexp    ${check_startfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check lwphelper start log for any exceptions         
    Skip If    ${check_startfile_status} == False    msg=Start lwphelper not present
    ${start_sch}=    Execute Command    ls -Art /eniq/log/sw_log/engine/lwphelper | grep -i "\\\bstart_lwph_" | tail -1
    Log    ${start_sch}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${start_sch}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/engine/lwphelper/${start_sch} | grep -i "successfully started"
        Should Contain    ${check_file}    successfully started 
    ELSE
        Skip    Start lwphelper not present
    END

Check lwphelper stop log is present         
    ${check_stopfile}=    Execute Command    ls -lrth /eniq/log/sw_log/engine/lwphelper | grep -i "\\bstop_lwph_" | tail -1
    Log   ${check_stopfile}
    ${check_stopfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stopfile}
    Log    ${check_stopfile_status}
    Set Suite Variable    ${check_stopfile_status}
    Set Suite Variable    ${check_stopfile}
    Skip If    ${check_stopfile_status} == False    msg=Stop lwphelper not present

Check lwphelper stop log user and permissions         
    Skip If    ${check_stopfile_status} == False    msg=Stop lwphelper not present
    Should Match Regexp    ${check_stopfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check lwphelper stop log for any exceptions         
    Skip If    ${check_stopfile_status} == False    msg=Stop lwphelper not present
    ${stop}=    Execute Command    ls -Art /eniq/log/sw_log/engine/lwphelper | grep -i "\\bstop_lwph_" | tail -1
    Log    ${stop}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${stop}
    IF    ${file_status} == True
        ${check_file}=    Execute Command    cat /eniq/log/sw_log/engine/lwphelper/${stop} | grep -i "stopped"
        Should Contain    ${check_file}    stopped
    ELSE
        Skip    stop lwphelper not present
    END


Check lwphelper log is present        
    ${ct_lwp_date}=    Execute Command    date +"%Y_%m_%d"
    ${check_lwpfile}=    Execute Command    ls -lrth /eniq/log/sw_log/engine/lwphelper | grep -i "\\blwphelper-${ct_lwp_date}" | tail -1
    Log   ${check_lwpfile}
    ${check_lwpfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_lwpfile}
    Log    ${check_lwpfile_status}
    Set Suite Variable    ${check_lwpfile_status}
    Set Suite Variable    ${check_lwpfile}
    Skip If    ${check_lwpfile_status} == False    msg=scheduler log file not present

Check lwphelper log user and permissions        
    Skip If    ${check_lwpfile_status} == False    msg=scheduler log file not present
    Should Match Regexp    ${check_lwpfile}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

Check lwphelper log for any exceptions        
    Skip If    ${check_lwpfile_status} == False    msg=scheduler log file not present
    ${ct_lwp_date}=    Execute Command    date +"%Y_%m_%d"
    ${lwp_file}=    Execute Command    ls -Art /eniq/log/sw_log/engine/lwphelper | grep -i "\\blwphelper-${ct_lwp_date}"
    Log   ${lwp_file}
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${lwp_file}
    Log    ${file_status}
    IF    ${file_status} == True
        ${check_lwp_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$2 > date' /eniq/log/sw_log/engine/lwphelper/${lwp_file} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}  
        Should Be Empty    ${check_lwp_logs}
    ELSE
        Skip    lwphelper not present
    END

*** Keywords ***
Suite setup steps for scheduler
    Open connection as root user
    ${check_lwp_dir}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i "\\blwphelper\\b"
    ${lwp_dir_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_lwp_dir} 
    Set Suite Variable    ${check_lwp_dir}
    Skip If    ${lwp_dir_status} == False    msg=lwphelper dir not present