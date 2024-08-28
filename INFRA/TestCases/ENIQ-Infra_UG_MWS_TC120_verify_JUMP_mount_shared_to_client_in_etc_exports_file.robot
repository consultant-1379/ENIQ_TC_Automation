***Settings ***
Library    SSHLibrary
Library    ../Scripts/verify_client_ips_in_etc_exports_file.py
Resource    ../Resources/Keywords/check_jump_mount_shared_to_client_in_etc_exports.robot
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    /JUMP mount is not shared to client in /ect/exports
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Check /JUMP mount is not shared to client in /ect/exports
    ${output}=    check_client_ips_in_etc_export_file    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain     ${output}    True