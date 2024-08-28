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
check for SystemMaxUse
    ${output}=    Execute Command    cat /etc/systemd/journald.conf|grep SystemMaxUse=8G
    Should Not Be Empty     ${output}

