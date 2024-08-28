*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keyword/verify_san_type_is_unity_TC.robot


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniqhost}
    Login    ${eniquser}    ${eniqpwd}    delay=1

*** Test Cases ***

check san type is unity

    ${output_JUMP}=    check_san_type_unity
    Should Be Equal    ${output_JUMP}    unity    


