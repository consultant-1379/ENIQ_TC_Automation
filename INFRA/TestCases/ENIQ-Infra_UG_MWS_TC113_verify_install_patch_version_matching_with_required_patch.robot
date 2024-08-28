*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/Variables.py
Library    ../Scripts/get_latest_install_patch_media.py
Library    ../Scripts/get_patch_media.py

Test Setup    Login to mws
Test Teardown    Close All Connections

*** Keywords ***
Login to mws
    Open Connection    ${mwshost}
    Login    ${mwsuser}    ${mwspwd}    delay=1

*** Test Cases ***

Verify rhel install patch bundle version cached in mws server matches the required patch bundle passed during mws configuration

    ${output}=    get_kernal_version    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    ${output1}=    get_patch_version    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output1}
    ${oput}=    Execute Command    cat /JUMP/UPGRADE_PATCH_MEDIA/${output}/.upgrade_patch_boot_media | grep 'bundle_version'
    Should Contain    ${oput}    ${output1}