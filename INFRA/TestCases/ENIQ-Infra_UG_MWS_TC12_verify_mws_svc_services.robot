*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py

Resource    ../Resources/Keywords/checknamed_service_TC.robot
Resource    ../Resources/Keywords/checknfs_service_TC.robot
Resource    ../Resources/Keywords/checkautofs_service_TC.robot
Resource    ../Resources/Keywords/checkmultiuser_service_TC.robot
Resource    ../Resources/Keywords/checktftp_service_TC.robot
Resource    ../Resources/Keywords/checkxinetd_service_TC.robot


Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

check nfs service is active

    ${nfs_active}=    check_nfs_service
    Should Contain    ${nfs_active}    Active: active

check nfs service is enabled

    ${nfs_enabled}=    check_nfs_service
    Should Contain    ${nfs_enabled}    ; enabled;


check autofs service is active

    ${autofs_active}=    check_autofs_service
    Should Contain    ${autofs_active}    Active: active

check autofs service is enabled

    ${autofs_enabled}=    check_autofs_service
    Should Contain    ${autofs_enabled}    ; enabled;


check multiuser service is active

    ${multiuser_active}=    check_multiuser_service
    Should Contain    ${multiuser_active}    Active: active

check multiuser service is enabled

    ${multiuser_enabled}=    check_multiuser_service
    Should Contain    ${multiuser_enabled}    ; enabled;


check tftp service is active

    ${tftp_active}=    check_tftp_service
    Should Contain    ${tftp_active}    Active: active

check tftp service is enabled

    ${tftp_enabled}=    check_tftp_service
    Should Contain    ${tftp_enabled}    ; enabled;


check xinet service is active

    ${xinet_active}=    check_xinetd_service
    Should Contain    ${xinet_active}    Active: active

check xinet service is enabled

    ${xinet_enabled}=    check_xinetd_service
    Should Contain    ${xinet_enabled}    ; enabled;





