*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/variables_for_robot.py
Library    SSHLibrary
Resource    ../Resources/Keywords/checkJUMPpartition_TC.robot
Resource    ../Resources/Keywords/checkbootpartition_TC.robot
Resource    ../Resources/Keywords/checkrootpartition_TC.robot
Resource    ../Resources/Keywords/checkefipartition_TC.robot
Resource    ../Resources/Keywords/checkswappartition_TC.robot
Resource    ../Resources/Keywords/checkvarpartition_TC.robot

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1


*** Test Cases ***
check for boot partition
    ${output_boot}=    check_boot
    Should Contain    ${output_boot}    boot

Check for JUMP partition
    ${output_jump}=    check_JUMP
    Should Contain    ${output_jump}    JUMP

Check for / partition
    ${output_root}=    check_root
    Should Contain    ${output_root}    root

Check for var partition
    ${output_var}=    check_var
    Should Contain    ${output_var}    var

Check for swap partition
    ${output_swap}=    check_swap
    Should Not Be Empty    ${output_swap}    



