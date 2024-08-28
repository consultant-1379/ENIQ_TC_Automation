*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkbcpackage_TC.robot


Test Setup    Login to mws
#Test Teardown    teardown activity

*** Keywords ***

#teardown activity
#    Run Keyword If Test Passed    log    ${output_bc} is installed successfully
#    Run Keyword If Test Failed    log    ${output_bc} is not installed

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check if bc package successfully installed

    ${output_bc}=    check_bc_package 
    Should Not Be Empty    ${output_bc}   


