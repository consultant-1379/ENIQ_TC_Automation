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
check for repo
    ${output}=    Execute Command    ls /etc/yum.repos.d|grep temp_rhel_update.repo
    Should Be Empty     ${output}


