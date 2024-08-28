*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_client_deploy_type.py

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
verify if IPv4 is not configured on IPv6 only deployment 

    ${output}=    check_client_ip_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="IPv6"
        ${IPv4_ADDR}=    Execute Command     cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -w "CLIENT_IP_ADDR" | cut -d'=' -f2-
        ${output}=    Execute Command     ip a | grep ${IPv4_ADDR}
        Should Be Empty    ${output}
    END
