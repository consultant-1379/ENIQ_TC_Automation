*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keywords/Verify_MWS_history_file_exists_on_upgrade_server_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check MWS File exists

    ${output_JUMP}=    check_mws_history_file_exists
    Should Not Be Empty    ${output_JUMP}    

