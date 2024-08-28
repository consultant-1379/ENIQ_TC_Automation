*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py
Library    SSHLibrary
Resource    ../Resources/Keywords/checkforpatchdirectory_TC.robot
Resource    ../Resources/Keywords/checkforsnapshotcleanup_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1


*** Test Cases ***
check for rootsnap cleanup
    ${output_rootsnap}=    check_for_rootsnap_cleanup
    Should Be Empty    ${output_rootsnap}   

check for varsnap cleanup
    ${output_varsnap}=    check_for_varsnap_cleanup
    Should Be Empty    ${output_varsnap}

check for patch directory
    ${output_patch}=    check_for_patch_directory
    Should Not Contain    ${output_patch}    No such file or directory
