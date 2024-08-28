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
check for DefaultLimitNOFILE entry
    ${output}=    Execute Command    cat /etc/systemd/system.conf|grep DefaultLimitNOFILE=65536
    Should Not Be Empty     ${output}


