*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    ../Scripts/check_one_entry_BLK_STORAGE_IP_SP.py
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
Verify if ENIQ is connected with VNX or Unity/Unityxt
    ${strg_config}=    Verify_if_ENIQ_is_connected_with_storage    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${strg_config}"=="True"
        ${output}=    Verify_if_ENIQ_is_connected    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
        IF    "${output}"=="VNX"
            Log To Console    VNX is not supported hardware. Hence, passing the test case.     
        ELSE IF     "${output}"=="Unity"
            Log To Console    Unity/UnityXT is supported.
        ELSE
            Should Contain    ${output}    Unity
        END
    END 

