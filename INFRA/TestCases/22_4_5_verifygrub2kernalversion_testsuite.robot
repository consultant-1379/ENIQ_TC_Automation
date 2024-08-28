*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keyword/verifygrub2kernal_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check kernal version 

    ${output_JUMP}=    check_kernal_version
    Should Be Equal    ${output_JUMP}    True

