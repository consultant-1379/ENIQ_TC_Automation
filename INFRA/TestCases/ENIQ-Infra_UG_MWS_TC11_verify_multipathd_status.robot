*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkmultipathd_status_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check multipathd inactive

    ${output_inactive}=    check_multipathd_status
    Should Contain    ${output_inactive}    Active: inactive


check multipathd disabled

    ${output_disabled}=    check_multipathd_status
    Should Contain    ${output_disabled}    ; enabled;

