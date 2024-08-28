*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to mws
Test Teardown    Close All Connections
*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1
*** Test Cases ***
check if os_backup directory not exist
    ${output_JUMP}=    Execute Command    ls /JUMP/ |grep OS_BACK_UP
    Should Be Empty    ${output_JUMP}
