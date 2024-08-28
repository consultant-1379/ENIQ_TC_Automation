*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1


*** Test Cases ***
check for dhcp details
    ${output}=    Execute Command   cat /JUMP/LIN_MEDIA/1/kickstart/${client_server}/${client_server}_ks_cfg.txt
    Should Not Be Empty     ${output}

