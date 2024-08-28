*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1
*** Test Cases ***
Verify if MWS entry is exist /etc/hosts file
    ${output}=    Execute Command     cat /etc/hosts | grep -w "MWS"
    Should Not Be Empty    ${output}
    
