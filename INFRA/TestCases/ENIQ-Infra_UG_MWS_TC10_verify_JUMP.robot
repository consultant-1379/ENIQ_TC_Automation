*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkJUMPpartition_TC.robot
Resource    ../Resources/Keywords/checketc_fstab_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check for JUMP parition in etc_fstab

    ${output_JUMP}=    check_etc_fstab_JUMP
    Should Contain    ${output_JUMP}    1

check for JUMP partition in df_h

    ${output_dfh}=    check_JUMP
    Should Contain    ${output_dfh}    JUMP  

