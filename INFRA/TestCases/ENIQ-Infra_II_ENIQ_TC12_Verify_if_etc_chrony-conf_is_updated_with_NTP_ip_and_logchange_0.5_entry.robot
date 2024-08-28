*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
check for ntp ip and logchange entry
    ${output}=    Execute Command    cat /etc/chrony.conf
    Should Contain     ${output}    logchange 0.5

