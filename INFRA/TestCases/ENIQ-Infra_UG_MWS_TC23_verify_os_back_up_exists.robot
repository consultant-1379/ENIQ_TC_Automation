*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variable_patch_TC.py
Library    SSHLibrary
Resource    ../Resources/Keywords/verify_os_back_up_exists_TC.robot

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1


*** Test Cases ***
check for os_back_up_directory
    ${output_os_backup}=    check_os_back_up_directory
    Should Be Empty     ${output_os_backup} 

