*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkmountpath_MWS_TC.robot

*** Keywords ***
teardown activities 
    
    Run Keyword If Test Passed    log    Patch is mounted successfully
    Run Keyword If Test Failed    log    Patch is not mounted
*** Test Cases ***
check mount path

    ${output_is_patch_mounted}=    check_mount_path_MWS    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${output_is_patch_mounted}    True

