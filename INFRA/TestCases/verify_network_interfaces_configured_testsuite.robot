*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/checknetworkinterfaces_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check if storage vlan configured
    
    IF    len($storage_vlan) == 0
        Skip
    ELSE
        ${output_storage}=    check_network_interfaces    ${storage_vlan}
        Should Contain    ${output_storage}    inet
    END

check if backup vlan configured

    IF    len($backup_vlan) == 0
        Skip
    ELSE
        ${output_backup}=    check_network_interfaces    ${backup_vlan}
        Should Contain    ${output_backup}    inet
    END 
   

check if management vlan configured

    IF    len($management_vlan) == 0
        Skip
    ELSE
        ${output_management}=    check_network_interfaces    ${management_vlan}
        Should Contain    ${output_management}     inet
    END




