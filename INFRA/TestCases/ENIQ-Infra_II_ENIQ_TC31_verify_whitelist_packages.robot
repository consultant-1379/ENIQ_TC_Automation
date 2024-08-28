*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variables_for_robot.py
Resource    ../Resources/Keywords/check_glibc_debuginfo_package_Keyword.robot
Resource    ../Resources/Keywords/check_kernel_debuginfo_package_Keyword.robot
Resource    ../Resources/Keywords/check_debuginfo_common_package_Keyword.robot

Test Setup    Login to mws
Test Teardown    teardown activity

*** Keywords ***

teardown activity
   
    Run Keyword If Test Failed    log    whitelist packages have not been installed
    Close All Connections

Login to mws
   
    Open Connection    ${hostname}
    Login    ${username}    ${password}    delay=1

*** Test Cases ***

check if glibc_debuginfo package successfully installed

    ${output_glibc}=    check_glibc_debuginfo_package
    Should Not Be Empty    ${output_glibc}

check if kernel_debuginfo package successfully installed

    ${output_kernel}=    check_kernel_debuginfo_package
    Should Not Be Empty    ${output_kernel}

check if debuginfo_common package successfully installed

    ${output_common}=    check_debuginfo_common_package
    Should Not Be Empty    ${output_common}

