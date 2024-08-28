*** settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1




*** Test Cases ***
check for Packages
    ${output}=    Execute Command    cat /etc/.ks_serv_ip_patch
    Log    ${output}
    Should Not Be Empty     ${output}



