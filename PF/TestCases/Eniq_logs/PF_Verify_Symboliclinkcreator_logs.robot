*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup   Suite setup steps for symbolilinkcreator
Test Teardown   Close All Connections

*** Test Cases ***
Check symboliclinkcreater dir user and permissions
    Should Match Regexp   ${check_sch_dir}    ^drwxr-x---[^a-zA-Z]+dcuser\\b

check symboliclinkcreator-common log is present
    ${check_symbolic}=    Execute Command    ls -lrth /eniq/log/sw_log/symboliclinkcreator | grep -i "symboliclinkcreator-" | tail -1
    Log   ${check_symbolic}
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_symbolic}
    Log    ${check_symbolicfile_status}
    Set Suite Variable    ${check_symbolicfile_status}
    Set Suite Variable    ${check_symbolic}
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present

check symboliclinkcreator-common log user and permissions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    Should Match Regexp    ${check_symbolic}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check symboliclinkcreator-common log for any exceptions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_symbolic}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "symboliclinkcreator-" | tail -1
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_symbolic}
    IF    ${file_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/symboliclinkcreator/${check_symbolic} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    symboliclink creator file not present
    END

check symboliclinkcreator stop-fls log is present
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_stop}=    Execute Command    ls -lrth /eniq/log/sw_log/symboliclinkcreator | grep -i "stop_fls_" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stop}
    Log    ${check_symbolicfile_status}
    Set Suite Variable    ${check_stop}
    Set Suite Variable    ${check_symbolicfile_status}
    Skip If    ${check_symbolicfile_status} == False    msg=stopfls file not present

check symboliclinkcreator stop-fls log user and permissions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    Should Match Regexp    ${check_stop}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check symboliclinkcreator stop-fls log any exceptions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_stop}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "stop_fls_" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stop}
    IF    ${check_symbolicfile_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/symboliclinkcreator/${check_stop} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    stop fls file not present
    END

check symboliclinkcreator start-fls log is present
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_start}=    Execute Command    ls -lrth /eniq/log/sw_log/symboliclinkcreator | grep -i "start_fls_" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_start}
    Log    ${check_symbolicfile_status}
    Set Suite Variable    ${check_start}
    Set Suite Variable    ${check_symbolicfile_status}
    Skip If    ${check_symbolicfile_status} == False    msg=startfls file not present

check symboliclinkcreator start-fls log user and permissions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    Should Match Regexp    ${check_start}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check symboliclinkcreator start-fls log any exceptions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_start}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "start_fls_" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_start}
    IF    ${check_symbolicfile_status} == True
        # ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/symboliclinkcreator/${check_start} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        ${check_scheap_logs}    ${stderr}=    Execute Command    cat /eniq/log/sw_log/symboliclinkcreator/${check_start} | grep -i "FLS service successfully started"    return_stderr=True 
        Should Be Empty    ${stderr}
        Should Not Be Empty    ${check_scheap_logs}
    ELSE
        Skip    start fls file not present
    END

check symboliclinkcreator DeleteSymlinkFile log is present
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_deletesymlink}=    Execute Command    ls -lrth /eniq/log/sw_log/symboliclinkcreator | grep -i "DeleteSymlinkFile-" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_deletesymlink}
    Log    ${check_symbolicfile_status}
    Set Suite Variable    ${check_deletesymlink}
    Set Suite Variable    ${check_symbolicfile_status}
    Skip If    ${check_symbolicfile_status} == False    msg=DeleteSymlinkFile file not present

check symboliclinkcreator DeleteSymlinkFile log user and permissions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater DeleteSymlinkFile file not present
    Should Match Regexp    ${check_deletesymlink}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check symboliclinkcreator DeleteSymlinkFile log any exceptions
    Skip If    ${check_symbolicfile_status} == False    msg=symboliclinkcreater file not present
    ${check_del}=    Execute Command    ls -Arth /eniq/log/sw_log/symboliclinkcreator | grep -i "DeleteSymlinkFile-" | tail -1
    ${check_symbolicfile_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_del}
    IF    ${check_symbolicfile_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/symboliclinkcreator/${check_del} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip     DeleteSymlink file not present
    END
    
*** Keywords ***
Suite setup steps for symbolilinkcreator
    Open connection as root user
    ${check_sch_dir}=    Execute Command    ls -lrth /eniq/log/sw_log/ | grep -i "\\bsymboliclinkcreator\\b"
    ${sch_dir_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_sch_dir} 
    Set Suite Variable    ${check_sch_dir}
    Set Suite Variable    ${sch_dir_status}
    Skip If    ${sch_dir_status} == False    msg=symboliclinkcreator dir not present
    