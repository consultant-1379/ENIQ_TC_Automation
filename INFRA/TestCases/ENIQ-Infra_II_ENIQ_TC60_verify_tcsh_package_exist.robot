*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variable_patch_TC.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1




*** Test Cases ***
check for tcsh
    ${output}=    Execute Command    rpm -qa|grep tcsh
    Should Not Be Empty     ${output}

