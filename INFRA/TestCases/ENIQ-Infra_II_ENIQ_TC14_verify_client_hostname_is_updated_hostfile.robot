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
check for hostname is updated
    ${output}=    Execute Command    cat /var/tmp/.hostfile
    Should Contain     ${hostname}    ${output}

