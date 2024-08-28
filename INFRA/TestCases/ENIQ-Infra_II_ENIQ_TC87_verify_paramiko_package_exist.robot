*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checkparamikopackage_Keyword.robot

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
    Run Keyword If Test Failed    log    paramiko package is not installed
    Close All Connections

Login to mws
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***

check paramiko package successfully installed

    ${output_paramiko}=    check_paramiko_package
    Should Contain    ${output_paramiko}    paramiko

