
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
verify etc hosts file has IPv4 host entries in IPv6 deployment

    ${output}=    check_client_ip_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="IPv6"
        ${IPv4_addr}=    Execute Command    cat /eniq/installation/config/$(hostname)/$(hostname)_ks_cfg.txt | grep -w "CLIENT_IP_ADDR" | cut -d'=' -f2-
        ${mws_hostname}=    Execute Command    cat /eniq/installation/config/INSTALL_SERVER
        ${mws_ipv4}=    Execute Command    nslookup ${mws_hostname} | grep 'Address: ' | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'
        ${op1}=    Execute Command    cat /etc/hosts | grep ${IPv4_addr}
        ${op2}=    Execute Command    cat /etc/hosts | grep ${mws_ipv4}
        Should Be Empty    ${op1}    ${op2}
    END
