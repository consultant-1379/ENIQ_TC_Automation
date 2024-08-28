
*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_client_deploy_type.py
Library    ../Scripts/ip_entry_check.py

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
verify etc hosts file updated with MWS IPv6 ip if deployment type is IPv6

    ${output}=    check_client_ip_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="IPv6"
        ${MWS_hostname}=    Execute Command     cat /eniq/installation/config/INSTALL_SERVER
        ${MWS_V6_ADDR}=    Execute Command     getent ahostsv6 ${MWS_hostname} | head -1 |cut -d' ' -f1
        ${output}=    Execute Command     cat /etc/hosts
        ${op}=    check_ip    ${MWS_V6_ADDR}    ${output}
        Should Contain    ${op}    True
    END
