*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1




*** Test Cases ***
check for directory
    ${output}=    Execute Command    last reboot|head -1
    ${output1}=    Execute Command    uname -r | cut -b 1-16
    Should Contain    ${output}    ${output1}

