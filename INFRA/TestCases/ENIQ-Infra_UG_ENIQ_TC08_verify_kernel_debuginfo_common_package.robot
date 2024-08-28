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
check if kernel-debug-debuginfo package successfully installed
    ${output}=    Execute Command    rpm -qa|grep -i kernel-debuginfo-common
    Should Not Be Empty    ${output}

