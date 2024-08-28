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
check paramiko package successfully installed
    ${output_paramiko}=    Execute Command    rpm -qa|grep python-paramiko
    Should Not Be Empty    ${output_paramiko}

