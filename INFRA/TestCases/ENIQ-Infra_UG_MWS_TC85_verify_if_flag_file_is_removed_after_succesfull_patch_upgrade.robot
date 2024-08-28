*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py


Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    paramiko package is not installed
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for file
    ${output}=    Execute Command    cd var/rhel_patch_upgrade_in_progress
    Should Be Empty    ${output}

