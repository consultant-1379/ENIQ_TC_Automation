*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkERICddcpackage_TC.robot


Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Passed    log    ERICddc is not installed
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

verify that ERICddc packages are not installed

    ${output_ddc}=    check_ERICddc_package
    Should Be Empty    ${output_ddc}

