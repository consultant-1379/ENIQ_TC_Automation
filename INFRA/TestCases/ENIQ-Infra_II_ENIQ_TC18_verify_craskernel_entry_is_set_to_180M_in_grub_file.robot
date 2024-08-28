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
check for craskernel entry as 180M
    ${output}=    Execute Command    cat /etc/default/grub |grep "crashkernel=180M"
    Should Not Be Empty     ${output}


