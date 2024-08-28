*** Settings ***
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/verify_latest_om_media.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
check for latest om media in DDC repo
    ${value}    check_emc_package_exist    ${eniq_upg_hostname}     ${eniq_upg_username}    ${eniq_upg_password}
    Log To Console    ${value}

    ${output}=    Execute Command    cat /etc/yum.repos.d/ericDDC.repo |grep baseurl
    Should Contain     ${output}    ${value}


