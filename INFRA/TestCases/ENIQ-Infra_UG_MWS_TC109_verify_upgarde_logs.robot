*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for upgrade logs
    ${output}=    Execute Command    ls /var/ericsson/log/patch | grep upgrade_patchrhel.bsh
    Should Not Be Empty     ${output}


