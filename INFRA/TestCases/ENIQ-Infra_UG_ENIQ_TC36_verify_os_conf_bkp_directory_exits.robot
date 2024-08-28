*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/update_check.py
Library    SSHLibrary
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1
*** Test Cases ***
Check for os back up
    ${value}=    update_check    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${value}"=="True"
        ${output2}=    Execute Command    ls /opt|grep OS_CONF_BKP
        Should Not Be Empty    ${output2}
    END
