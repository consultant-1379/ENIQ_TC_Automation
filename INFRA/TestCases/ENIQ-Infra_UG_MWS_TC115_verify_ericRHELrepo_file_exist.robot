*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

Verify ericRHEL.repo file exist on mws

    ${output}=    Execute Command    ls -lrt /etc/yum.repos.d/ericRHEL.repo
    Should Not Be Empty    ${output}