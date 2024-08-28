*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Resource    ../Resources/Keywords/verify_Boot_Mode_of_server_TC.robot
Resource    ../Resources/Keywords/verify_grubfile_present_in_path_TC.robot

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check Boot Mode

    ${output_JUMP}=    check_Boot_Mode
    Should Contain    ${output_JUMP}    BIOS    

check grub file

    ${output}=    check_grub_file
    Should Not Be Empty    ${output}
