***Settings ***
Library    SSHLibrary
Library    ../Scripts/verify_entries_in_ks_cfg.py
Variables    ../Resources/Variables/variables_for_robot.py
Test Setup    Login to eniq
Test Teardown    Close All Connections
*** Keywords ***
Login to eniq
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1
*** Test Cases ***
Check for entries in ks cfg file
    ${value}=    check_req_entries    ${hostname}     ${username}    ${password}
    Should Contain     True    ${value}

