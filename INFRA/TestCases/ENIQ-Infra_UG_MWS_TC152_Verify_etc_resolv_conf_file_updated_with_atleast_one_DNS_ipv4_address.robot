
*** Settings ***
Library    SSHLibrary
Library    ../Scripts/check_blade_rack_type.py
Library    ../Scripts/verify_etc_resolv_conf_file_updated_with_dns_ipv4address.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check DNS ipv4 address present in etc resolv conf file

    ${output}=    check_blade_rack_type    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    IF    "${output}"=="DL"
	
        ${result}=    check_for_dns_ipv4_entry    ${mwshost}    ${mwsuser}    ${mwspwd}
        Should Contain    ${result}    True

   END
