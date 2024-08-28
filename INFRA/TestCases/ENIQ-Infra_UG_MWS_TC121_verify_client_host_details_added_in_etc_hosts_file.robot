***Settings ***
Library    SSHLibrary
Library    ../Scripts/verify_client_ips_in_etc_hosts_file.py
Resource    ../Resources/Keywords/check_jump_mount_shared_to_client_in_etc_hosts.robot
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    Client host details are not added in /etc/hosts
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Check client host details are added in /etc/hosts
    ${output}=    check_client_ips_in_etc_hosts_file    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain     ${output}    True