*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    ../Scripts/check_current_generation.py
Variables    ../Resources/Variables/Variables.py

Library    SSHLibrary
Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1

*** Test Cases ***
verify server's current generation
    ${output}=    Verify_the_current_generation    ${eniq_upg_hostname}    ${eniq_upg_username}    ${eniq_upg_password}
    IF    "${output}"=="Gen10/Gen10Plus"
        Log To Console    Gen10/Gen10Plus is supported. 
    ELSE
        Log To Console    Gen8/Gen9 is not supported hardware. Hence, passing the test case.
    END
 

