*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keywords/verify_UnisphereCLI_latest_version_on_MWS_server_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check UnisphereCLI latest version

    ${output_JUMP}=    check_UnisphereCLI_version
    Should Be Equal    ${output_JUMP}    ${UnisphereCLI_version}


