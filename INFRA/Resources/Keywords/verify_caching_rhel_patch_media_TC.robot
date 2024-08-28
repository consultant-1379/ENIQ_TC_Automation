*** Settings ***
Library    ../../Scripts/compare_kernal_version.py


*** Keywords ***
verify_cached_rhel_patch_media
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    compare_kernal_version    ${host}    ${user}    ${pwd}
    [Return]    ${result}


