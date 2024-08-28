*** Settings ***
Library    ../Scripts/checkupgradespace_MWS.py
Resource    ../Resources/Keywords/checkforupgradespace_MWS_Keyword.robot
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py

Test Teardown    teardown tasks

*** Keywords ***
teardown tasks

    Run Keyword If Test Failed    log    Insufficient space available for mws upgrade
    Run Keyword If Test Passed    log    Sufficient space available for mws upgrade

*** Test Cases ***
check if enough space for upgrade in mws 

    ${result}=    check_upgrade_space_MWS    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${result}    True

