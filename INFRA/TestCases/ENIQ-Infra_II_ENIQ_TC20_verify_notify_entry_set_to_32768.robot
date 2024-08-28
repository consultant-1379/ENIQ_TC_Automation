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
check for notify
    ${output}=    Execute Command    cat /etc/security/limits.conf |grep *                 -      nofile  32768

    Should Not Be Empty     ${output}

