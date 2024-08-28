*** Settings ***
Library    SSHLibrary
Library    ../Scripts/check_blade_rack_type.py
Library    ../Scripts/verify_service_interface_file_updated_with_dnsip.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check service inteface file updated with ipv4 and ipv6 DNS
    ${output}=    check_blade_rack_type    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    IF    "${output}"=="DL"

        ${result}=    check_service_interface_file_dnsip    ${mwshost}    ${mwsuser}    ${mwspwd}
        Should Contain    ${result}    True

    END

