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
check for profile file
    ${output}=    Execute Command    cat /etc/profile
    Should Contain     ${output}    PATH=$PATH:/opt/Unisphere/bin:/opt/Navisphere/bin


