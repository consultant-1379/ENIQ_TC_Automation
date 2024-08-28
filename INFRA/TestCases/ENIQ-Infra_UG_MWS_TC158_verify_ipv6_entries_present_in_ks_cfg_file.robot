***Settings ***
Library    SSHLibrary
Library    ../Scripts/verify_ipv6_entries_present_in_ks_cfg_file.py
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    ipv6 entries not present in ks cfg file IPv6 Deployment
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Check ipv6 entries present in ks cfg file IPv6 Deployment
    ${output}=    ipv6_entries_present_in_ks_cfg_file    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain     ${output}    True