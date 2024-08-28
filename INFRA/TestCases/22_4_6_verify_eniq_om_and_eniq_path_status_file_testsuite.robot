*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keywords/verify_eniq_om_status_file_exists_TC.robot
Resource    ../Resources/Keywords/verify_eniq_patch_status_file_exists_TC.robot



Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***

check om status file

    ${output_JUMP}=    check_eniq_om_status_file
    Should Be Empty    ${output_JUMP}

check patch status file

    ${output}=    check_eniq_patch_status_file
    Should Be Empty    ${output}

