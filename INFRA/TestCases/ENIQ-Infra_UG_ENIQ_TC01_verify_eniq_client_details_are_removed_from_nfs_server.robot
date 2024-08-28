*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
check for eniq client
    ${output}=    Execute Command    ls /net/10.45.196.7/OS_BACK_UP | grep ${eniq_upg_hostname}
    Should Be Empty     ${output}


