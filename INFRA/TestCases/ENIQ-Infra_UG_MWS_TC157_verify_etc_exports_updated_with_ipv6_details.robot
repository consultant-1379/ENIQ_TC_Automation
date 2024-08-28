***Settings ***
Library    SSHLibrary
Library    ../Scripts/check_etc_exports_updated_with_ipv6_details.py
Variables    ../Resources/Variables/Variables.py

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    /etc/exports are not updated with IPv6 details for IPv6 Deployment
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***
Check /etc/exports updated with IPv6 details for IPv6 Deployment
    ${output}=    check_etc_exports_updated_with_ipv6_details    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain     ${output}    True