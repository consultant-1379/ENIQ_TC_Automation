*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1




*** Test Cases ***
check for bind libs
    ${output}=    Execute Command    rpm -qa|grep bind-libs
    Should Not Be Empty     ${output}



