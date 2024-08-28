*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/verify_dns_ip_is_updated.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
check for dns ip is updated in file
    ${output}=    check_emc_package_exist    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    Should Contain     ${output}    True


