*** Settings ***
Library    ../Scripts/check_nodehardening_on_mws_upgrade_server.py
Variables    ../Resources/Variables/Variables.py
Test Teardown    teardown tasks
*** Keywords ***
teardown tasks
    Run Keyword If Test Failed    log    File dont contain data
    Run Keyword If Test Passed    log    File do contain data
*** Test Cases ***
check node hardening rpm
    ${result}=    node_hradening_rpm    ${hostname}    ${username}    ${password}
    Should Contain    ${result}    true

