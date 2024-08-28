** Settings ***
Library    ../Scripts/checkpatchversion_wrapper.py
  
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variable_patch_TC.py
Library    SSHLibrary
Resource    ../Resources/Keywords/verify_kernal_versions_TC.robot

Test Teardown    teardown activities


*** Keywords ***
teardown activities

    Run Keyword If Test Failed    log    Patch Upgrade is Required
    Run Keyword If Test Passed    log    Patch Upgrade not required. Latest version of patch is installed.

*** Test Cases ***

check rhel patch version

    ${result}=    compare_kernal_version1    ${mwshost}    ${mwsuser}    ${mwspwd}    
    Should Contain    ${result}    True

