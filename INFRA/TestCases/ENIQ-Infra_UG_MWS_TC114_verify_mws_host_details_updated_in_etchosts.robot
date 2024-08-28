*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/get_hostname.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

Verify MWS host details updated successfuly in /etc/hosts
    ${mwshost1}=    hostname_filter    ${hostname}
    ${output_loghost}=    Execute Command    cat /etc/hosts | grep ${mwshost1}
    Should Contain    ${output_loghost}    ${mwshost1}    loghost