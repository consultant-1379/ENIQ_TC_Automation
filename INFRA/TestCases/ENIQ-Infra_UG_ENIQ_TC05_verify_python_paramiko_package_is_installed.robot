*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to eniq
Test Teardown    teardown activity

*** Keywords ***
teardown activity
    Run Keyword If Test Failed    log    paramiko package is not installed
    Close All Connections

Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
check paramiko package successfully installed
    ${output_paramiko}=    Execute Command    rpm -qa|grep python-paramiko
    Should Not Be Empty    ${output_paramiko}

