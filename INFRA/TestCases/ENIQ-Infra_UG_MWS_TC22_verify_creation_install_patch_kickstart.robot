*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variable_patch_TC.py
Library    SSHLibrary
Resource    ../Resources/Keywords/verify_creation_kickstart_repo_TC.robot
Resource     ../Resources/Keywords/verify_creation_kickstart_repo1_TC.robot

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1


*** Test Cases ***
check for kickstart_repo
    ${output_kickstart_repo}=    verify_creation_kickstart_repo
    Should Be Empty     ${output_kickstart_repo}

check for kickstart_repo1
    ${output_kickstart_repo1}=    verify_creation_kickstart_repo1
    Should Be Empty     ${output_kickstart_repo1}
