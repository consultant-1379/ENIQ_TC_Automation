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
check for VGs
    ${output}=    Execute Command   lvs |grep vg_root
    Should Not Be Empty     ${output}

check for LVs
    ${output1}=    Execute Command   lvs |grep lv_
    Should Not Be Empty     ${output1}



