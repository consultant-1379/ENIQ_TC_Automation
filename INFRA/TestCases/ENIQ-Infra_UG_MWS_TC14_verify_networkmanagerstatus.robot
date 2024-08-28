*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checknetworkmanagerstatus_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check networkmanager inactive

    ${output_inactive}=    check_networkmanager_status
    Should Contain    ${output_inactive}    Active: inactive


check networkmanager disabled

    ${output_disabled}=    check_networkmanager_status
    Should Contain    ${output_disabled}    ; disabled;

