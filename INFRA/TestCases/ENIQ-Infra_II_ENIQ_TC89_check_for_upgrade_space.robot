*** Settings ***
Resource    ../Resources/Keywords/checkforupgradespace_ENIQ_Keyword.robot
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py

Test Teardown    teardown tasks

*** Keywords ***
teardown tasks

    Run Keyword If Test Failed    log    Insufficient space available for ENIQ upgrade
    Run Keyword If Test Passed    log    Sufficient space available for ENIQ upgrade

*** Test Cases ***
check if enough space for upgrade in ENIQ

    ${result}=    check_upgrade_space_ENIQ    ${hostname}    ${username}    ${password}
    Should Contain    ${result}    True

