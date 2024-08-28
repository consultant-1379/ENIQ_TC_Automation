*** Settings ***
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    String
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Test Setup   Suite setup steps for engine
Test Teardown   Close All Connections

*** Test Cases ***
check engine dir user and permissions	
    Should Match Regexp   ${eng_sch_dir}    ^drwxr-x---[^a-zA-Z]+dcuser\\b

check engine log is present
    ${check_engine}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i " engine-" | tail -1
    Log   ${check_engine}
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_engine}
    Log    ${check_engine_status}
    Set Suite Variable    ${check_engine_status}
    Set Suite Variable    ${check_engine}
    Skip If    ${check_engine_status} == False    msg=engine file not present

check engine log user and permissions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    Should Match Regexp    ${check_engine}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check engine log for any exceptions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_engine}=    Execute Command    ls -Arth /eniq/log/sw_log/engine | grep -i "engine-" | tail -1
    ${file_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_engine}
    IF    ${file_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/engine/${check_engine} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    engine file not present
    END

check engine stop log is present
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_stop}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i "stop_engine_" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stop}
    Log    ${check_engine_status}
    Set Suite Variable    ${check_stop}
    Set Suite Variable    ${check_engine_status}
    SkipIf    ${check_engine_status} == False    msg=stopengine file not present
 
check engine stop log user and permissions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    Should Match Regexp    ${check_stop}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check engine stop log for any exceptions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_stop}=    Execute Command    ls -Arth /eniq/log/sw_log/engine | grep -i "stop_engine_" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_stop}
    Log    ${check_engine_status}
    IF    ${check_engine_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/engine/${check_stop} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    stop engine file not present
    END

check engine start log is present
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_start}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i "start_engine_" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_start}
    Log    ${check_engine_status}
    Set Suite Variable    ${check_start}
    Set Suite Variable    ${check_engine_status}
    SkipIf    ${check_engine_status} == False    msg=start engine file not present

check engine start log user and permissions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    Should Match Regexp    ${check_start}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check engine start log for any exceptions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_start}=    Execute Command    ls -Arth /eniq/log/sw_log/engine | grep -i "start_engine_" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_start}
    Log    ${check_engine_status}
    IF    ${check_engine_status} == True
        # ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/engine/${check_start} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk '/engine is running OK/ {data = ""} {data = data $0 RS} END {print data}' /eniq/log/sw_log/engine/${check_start} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    start engine file not present
    END

check engine heap log is present
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_heap}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i "engineHeap-" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_heap}
    Log    ${check_engine_status}
    Set Suite Variable    ${check_heap}
    Set Suite Variable    ${check_engine_status}
    SkipIf    ${check_engine_status} == False    msg=heap engine file not present

check engine heap log user and permissions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    Should Match Regexp    ${check_heap}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check engine heap log for any exceptions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_heap}=    Execute Command    ls -Arth /eniq/log/sw_log/engine | grep -i "engineHeap-" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_heap}
    Log    ${check_engine_status}
    IF    ${check_engine_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/engine/${check_heap} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    heap engine file not present
    END

check engine-priorityqueue log is present
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_priority}=    Execute Command    ls -lrth /eniq/log/sw_log/engine | grep -i "engine-PriorityQueue-" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_priority}
    Log    ${check_engine_status}
    Set Suite Variable    ${check_priority}
    Set Suite Variable    ${check_engine_status}
    SkipIf    ${check_engine_status} == False    msg=priority engine file not present

check engine-priorityqueue log user and permissions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    Should Match Regexp    ${check_priority}    ^-rw-r-----[^a-zA-Z]+dcuser\\b

check engine-priorityqueue log for any exceptions
    Skip If    ${check_engine_status} == False    msg=engine file not present
    ${check_priority}=    Execute Command    ls -Arth /eniq/log/sw_log/engine | grep -i "engine-PriorityQueue-" | tail -1
    ${check_engine_status}=    Run Keyword And Return Status    Should Not Be Empty    ${check_priority}
    Log    ${check_engine_status}
    IF    ${check_engine_status} == True
        ${check_scheap_logs}    ${stderr}=    Execute Command    awk -v date="$(date --date='30 minutes ago' +'%H:%M')" '$4 > date' /eniq/log/sw_log/engine/${check_priority} | grep -i "\\bexception\\b\\|\\bsevere\\b\\|\\bfailed\\b\\|\\berror\\b"    return_stderr=True
        Should Be Empty    ${stderr}
        Should Be Empty    ${check_scheap_logs}
    ELSE
        Skip    Priority engine file not present
    END

*** Keywords ***
Suite setup steps for engine
    Open connection as root user
    ${eng_sch_dir}=    Execute Command    ls -lrth /eniq/log/sw_log/ | grep -i "\\bengine\\b"
    ${eng_dir_status}=    Run Keyword And Return Status    Should Not Be Empty    ${eng_sch_dir} 
    Set Suite Variable    ${eng_sch_dir}
    Set Suite Variable    ${eng_dir_status}
    Skip If    ${eng_dir_status} == False    msg=engine dir not present