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
check for client
    ${output1}    Execute Command    hostname
    ${output}=    Execute Command    cat /etc/hosts | grep ${output1}
    Should Not Be Empty     ${output}


check for ip
    ${output4}    Execute Command    hostname
    ${output2}=    Execute Command    getent hosts ${output4}
    Should Not Be Empty    ${output2}

check for loghost
    ${output}=    Execute Command    cat /etc/hosts | grep loghost
    Should Not Be Empty     ${output}


