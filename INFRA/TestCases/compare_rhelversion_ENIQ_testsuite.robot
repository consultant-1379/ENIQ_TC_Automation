*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkrhelpatchversion_Keyword.robot

Test Teardown    teardown activities

*** Keywords ***

teardown activities
 
    Run Keyword If Test Failed    log    Patch Upgrade is Required
    Run Keyword If Test Passed    log    Patch Upgrade not required. Latest version of patch is installed.

*** Test Cases ***

check rhel patch version
    
    ${result}=    check_rhel_patch_version    ${mwshost}    ${mwsuser}    ${mwspwd}    ${eniqhost}    ${eniquser}    ${eniqpwd}
    Should Contain    ${result}    True

