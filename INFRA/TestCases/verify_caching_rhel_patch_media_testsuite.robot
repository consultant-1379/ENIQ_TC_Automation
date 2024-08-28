*** Settings ***
Library    CryptoLibrary    variable_decryption=True
Library    SSHLibrary
Variables    ../Resources/Variables/variable_patch_TC.py
Resource    ../Resources/Keywords/verify_caching_rhel_patch_media_TC.robot
Library    ../Scripts/compare_kernal_version.py


Test Teardown    teardown tasks


*** Keywords ***
teardown tasks
     Run Keyword If Test Failed    log    File dont contain data
     Run Keyword If Test Passed    log    File do contain data


*** Test Cases ***

check_rhel_patch_media_cached

    ${output_patch_media_cached}=    verify_cached_rhel_patch_media     ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Be Equal    ${output_patch_media_cached}    True

