*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_blade_rack_type.py
Library    ../Scripts/verify_new_mount_parameters_enabled_on_ENIQ_server.py
Library    ../Scripts/pre_cdb_pipeline_check.py

Test Setup    Login to ENIQ
Test Teardown    Close All Connections

*** Keywords ***
Login to ENIQ
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
Verify if new mount parameters are enabled on /home, /var/tmp, /tmp on ENIQ UG server

    ${output1}=    pre_cdb_check    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    ${output}=    check_blade_rack_type    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${output1}"=="False"
        IF    "${output}"=="BL"
            ${op1}=    Execute Command     df -h
            Should Contain    ${op1}     /home
            Should Contain    ${op1}     /tmp
            Should Contain    ${op1}     /var/tmp
            Should Contain    ${op1}     /var/log
            ${op2}=    check_mount_parameters_enabled    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
            Should Contain    ${op2}    True
        ELSE
            ${op}=    check_mount_parameters_enabled    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
            Should Contain    ${op}    True
        END
    END