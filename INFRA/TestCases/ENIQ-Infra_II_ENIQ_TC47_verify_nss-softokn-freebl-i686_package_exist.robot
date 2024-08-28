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
check for nss-softokn-freebl
    ${output}=    Execute Command    rpm -qa|grep nss-softokn-freebl|grep i686
    Should Not Be Empty     ${output}


