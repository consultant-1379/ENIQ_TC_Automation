*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
verify mwshealthcheck running on mws
    ${output}=    Execute Command    ls /var/tmp | grep mws_health_check_summary
    Should Not Be Empty     ${output}

