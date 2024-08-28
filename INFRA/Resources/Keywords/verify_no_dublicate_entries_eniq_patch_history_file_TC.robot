*** Settings ***
Library    ../../Scripts/verify_no_dublicate_entries_on_eniq_patch_historyfile.py


*** Keywords ***
check_mws_history_file_contain_datas
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_mws_history_file_contain_data    ${host}    ${user}    ${pwd}
    [Return]    ${result}

