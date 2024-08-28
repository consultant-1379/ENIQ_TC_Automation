*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_client_deploy_type.py
Library    ../Scripts/ip_entry_check.py

Test Setup    Login to ENIQ
Test Teardown    Close All Connections

*** Keywords ***
Login to ENIQ
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***
verify if IPv6 NTP IP is configured in chrony.conf file if deployment type is IPv6

    ${output}=    check_client_ip_type    ${hostname}    ${username}    ${password}
    Log To Console    ${output}
    IF    "${output}"=="IPv6"
        ${IPv6_ADDR}=    Execute Command     cat /eniq/installation/config/${hostname}/${hostname}_ks_cfg.txt | grep -w "CLIENT_TIMESERVE_V6" | cut -d "=" -f2
	    ${output1}=    Execute Command     cat /etc/chrony.conf
        ${op}=    check_ip    ${IPv6_ADDR}    ${output1}
        Should Contain    ${op}    True
    END
