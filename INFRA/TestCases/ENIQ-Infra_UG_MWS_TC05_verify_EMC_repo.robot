*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkEMC_repo_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

teardown activity
    Run Keyword If Test Failed    log    repo files for EMC have not been created

*** Test Cases ***

verify if EMC repo is created

    ${output_dir}=    check_EMC_repo
    Should Contain    ${output_dir}    ericEMC.repo

