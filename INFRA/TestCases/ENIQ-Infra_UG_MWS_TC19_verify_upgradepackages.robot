*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkhwcommpackage_TC.robot
Resource    ../Resources/Keywords/checkEMCpackage_TC.robot
Resource    ../Resources/Keywords/checkERICkickstartpackage_TC.robot


Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    required package is not installed
    Close All Connections

Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check hwcomm package successfully installed

    ${output_hwcomm}=    check_hwcomm_package
    Should Not Be Empty    ${output_hwcomm}

check ERICkickstart package successfully installed

    ${output_ERICkickstart}=    check_ERICkickstart
    Should Not Be Empty    ${output_ERICkickstart}

