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
verify IPv6 newtwork configured on eniq if deployment type is IPv6

    ${output}=    check_client_ip_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="IPv6"
        ${IPv6_addr}=    Execute Command     cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -w "CLIENT_IP_ADDR_V6" | cut -d'=' -f2-
        ${ip_a_oput}=    Execute Command     ip a
        ${op}=    check_ip    ${IPv6_addr}    ${ip_a_oput}
        Should Contain    ${op}    True
    END
