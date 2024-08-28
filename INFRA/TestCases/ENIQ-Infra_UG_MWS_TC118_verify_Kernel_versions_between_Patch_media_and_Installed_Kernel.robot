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
compare kernel version of patch media and installed kernel version

    ${output}=    get_kernal_version    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output}
    ${output1}=    get_patch_version    ${mwshost}    ${mwsuser}    ${mwspwd}
    Log To Console    ${output1}
    ${uname_oput}=    Execute Command     uname -r
    Log To Console    ${uname_oput}
    ${oput}=    Execute Command     ls -lrt /JUMP/UPGRADE_PATCH_MEDIA/${output}/RHEL/RHEL7.9-${output1}/packages/ | grep kernel-${uname_oput}
    Should Not Be Empty    ${oput}