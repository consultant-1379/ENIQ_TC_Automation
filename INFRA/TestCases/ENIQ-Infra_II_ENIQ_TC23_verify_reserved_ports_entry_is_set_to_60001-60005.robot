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
check for reserved port entry
    ${output}=    Execute Command     cat /etc/sysctl.conf|grep net.ipv4.ip_local_reserved_ports=60001-60005
    Should Not Be Empty     ${output}


