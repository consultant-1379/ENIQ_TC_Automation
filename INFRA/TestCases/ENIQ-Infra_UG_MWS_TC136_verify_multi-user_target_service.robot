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
check for multi-user active
    ${output}=    Execute Command     systemctl status multi-user.target
    Should Contain     ${output}    Active: active

check for multi-user enabled
    ${output}=    Execute Command     systemctl status multi-user.target
    Should Contain     ${output}    multi-user.target; enabled;




