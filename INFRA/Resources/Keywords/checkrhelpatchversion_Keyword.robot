*** Settings ***
Library    ../../Scripts/compare_rhelversion_ENIQ.py


*** Keywords ***
check_rhel_patch_version
    [Arguments]    ${preconfigured_mwshost}    ${preconfigured_mwsuser}    ${preconfigured_mwspwd}    ${eniqhost}    ${eniquser}    ${eniqpwd}
    ${result}=    compare_kernel_versions    ${preconfigured_mwshost}    ${preconfigured_mwsuser}    ${preconfigured_mwspwd}    ${eniqhost}    ${eniquser}    ${eniqpwd}
    [Return]    ${result}

