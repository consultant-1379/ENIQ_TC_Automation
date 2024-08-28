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

check if getty service is active

    ${output_JUMP}=    Execute Command    systemctl status serial-getty@ttyS0|grep active
    Should Not Be Empty    ${output_JUMP}

check if getty service is enable

    ${output_VARIABLE}=    Execute Command    systemctl  enable serial-getty@ttyS0|grep enabled
    Should Not Be Empty    ${output_VARIABLE}
