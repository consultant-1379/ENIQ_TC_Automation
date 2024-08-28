﻿*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py
Library    SSHLibrary


Test Setup    Login to eniq
Test Teardown    Close All Connections

*** Keywords ***
Login to eniq
    Open Connection    ${eniq_upg_hostname}
    Login    ${eniq_upg_username}    ${eniq_upg_password}    delay=1




*** Test Cases ***
check for yum-utils
    ${output}=    Execute Command    rpm -qa|grep bind-libs
    Should Not Be Empty     ${output}



