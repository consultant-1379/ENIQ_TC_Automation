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
    Log To Console    Logged in to MWS


*** Test Cases ***
check for dhcp details
    ${output}=    Execute Command    cd /ericsson/kickstart/bin/manage_linux_dhcp_clients.bsh -a list -c ${client_server}
    Should Not Be Empty     ${output}


