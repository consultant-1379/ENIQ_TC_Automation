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
Check for partition
    ${value}=    update_check    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${value}"=="True"
        ${output}=    Execute Command    ls /eniq/installation/config|grep eniq_patch_history
        Should Not Be Empty    ${output}
    END
