*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/check_vlan_id_created_gen10plus.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
check if vlan id created
    ${result}=    get_vlan_details    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${result}    True