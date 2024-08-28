*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to eniq
Test Teardown    teardown activity
*** Keywords ***
teardown activity

    Run Keyword If Test Failed    log    cup packages have been installed
    Close All Connections
Login to eniq

    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1
*** Test Cases ***
check if cup rpm not exist
    ${output}=    Execute Command    rpm -qa|grep -i cup
    Should Be Empty    ${output}

