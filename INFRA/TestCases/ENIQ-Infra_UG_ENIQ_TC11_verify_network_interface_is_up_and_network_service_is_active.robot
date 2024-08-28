*** Settings ***
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Test Setup    Login to eniq
Test Teardown    teardown activity
*** Keywords ***
teardown activity

    Run Keyword If Test Failed    log    whitelist packages have not been installed
    Close All Connections
Login to eniq

    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1
*** Test Cases ***
check if network service is up
    ${output}=    Execute Command    sudo ip link show
    Should Contain    ${output}    UP mode
check if network service is active
    ${output1}=    Execute Command    systemctl status network
    Should Contain    ${output1}     Active: active (exited)


