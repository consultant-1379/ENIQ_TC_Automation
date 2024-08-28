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
check for dcuser entry
    ${output}=    Execute Command    cat /etc/security/limits.d/20-nproc.conf |grep dcuser
    Should Not Be Empty     ${output}


