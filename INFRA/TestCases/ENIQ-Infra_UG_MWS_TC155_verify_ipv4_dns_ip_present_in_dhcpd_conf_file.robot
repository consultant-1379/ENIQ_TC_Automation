*** Settings ***
Library    SSHLibrary
Library    ../Scripts/verify_dhcpd_conf_file.py
Library    ../Scripts/check_blade_rack_type.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check ipv4 dns ip present in dhcpd conf file
    ${output}=    check_blade_rack_type    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    IF    "${output}"=="DL"

        ${result}=    check_dhcpd_conf_file    ${mwshost}    ${mwsuser}    ${mwspwd}
        Should Contain    ${result}    True

    END


