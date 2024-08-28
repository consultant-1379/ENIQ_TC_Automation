*** Settings ***
Library    ../../Scripts/verify_no_dublicate_entries_MWS_OM_MEDIA_STATUS.py


*** Keywords ***
check_mws_history_file_contain_datas
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_mws_history_file_contain_data    ${host}    ${user}    ${pwd}
    [Return]    ${result}


