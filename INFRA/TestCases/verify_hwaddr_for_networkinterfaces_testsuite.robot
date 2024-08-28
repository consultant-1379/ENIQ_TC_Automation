*** Settings ***
Library    ../Scripts/check_networkinterfaces_hwaddr.py
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py

Test Teardown    teardown tasks

*** Keywords ***
teardown tasks
    Run Keyword If Test Failed    log    hardware address not updated for existing network interfaces
    Run Keyword If Test Passed    log    hardware address updated for existing network interfaces

*** Test Cases ***
check if hwaddr updated for network interfaces

    ${result}=    check_networkinterfaces_configured    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${result}    True

