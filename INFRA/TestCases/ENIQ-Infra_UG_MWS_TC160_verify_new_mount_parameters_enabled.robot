*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_blade_rack_type.py
Library    ../Scripts/verify_new_mount_parameters_enabled_on_ENIQ_server.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Verify if new mount parameters are enabled on /home, /var/tmp, /tmp on MWS UG server

    ${output}=    check_blade_rack_type    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    IF    "${output}"=="BL"
        ${op1}=    Execute Command     df -h
        Should Contain    ${op1}     /home
        Should Contain    ${op1}     /tmp
        Should Contain    ${op1}     /var/tmp
        Should Contain    ${op1}     /var/log
        ${op2}=    check_mount_parameters_enabled    ${mwshost}    ${mwsuser}    ${mwspwd}
        Should Contain    ${op2}    True
    ELSE
        ${op}=    check_mount_parameters_enabled    ${mwshost}    ${mwsuser}    ${mwspwd}
        Should Contain    ${op}    True
    END
