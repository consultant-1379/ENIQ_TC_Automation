*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py


Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    mount path is not available
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check for mount path
    ${output}=    Execute Command    ls /JUMP/INSTALL_PATCH_MEDIA
    Should Not Be Empty    ${output}


