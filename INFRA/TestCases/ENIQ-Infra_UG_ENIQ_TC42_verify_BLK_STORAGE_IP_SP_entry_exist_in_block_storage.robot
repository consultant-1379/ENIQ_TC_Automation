*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    ../Scripts/check_aleast_one_entry_BLK_STORAGE_IP_SP.py
Library    ../Scripts/check_storage_is_configured_in_ENIQ.py
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
verify atleast one BLK_STORAGE_IP entry present in block_storage.ini file
    ${strg_config}=    Verify_if_ENIQ_is_connected_with_storage    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${strg_config}"=="True"
        ${output}=    Verify_Check    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
        Log To Console    ${output}
        Should Contain    ${output}    True 
    END