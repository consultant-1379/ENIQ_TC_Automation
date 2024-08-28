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
check for ericDDC
    ${output}=    Execute Command    ls /etc/yum.repos.d |grep ericDDC.repo
    Should Not Be Empty     ${output}


