*** Settings ***
Library    ../../Scripts/checkmountpath_MWS.py

*** Keywords ***
check_mount_path_mws
    [Arguments]    ${mwshost}    ${mwsuser}    ${mwspwd}
    ${output}=    check_mount_path    ${mwshost}    ${mwsuser}    ${mwspwd}
    [Return]    ${output}

