*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_storage_is_configured_in_ENIQ.py
Library    SSHLibrary

Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
Verify if block_storage.ini file exists
    ${strg_config}=    Verify_if_ENIQ_is_connected_with_storage    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${strg_config}"=="True"
        ${output}=    Execute Command    ls /eniq/installation/config/ | grep 'block_storage.ini'
        Should Not Be Empty     ${output}
	END

