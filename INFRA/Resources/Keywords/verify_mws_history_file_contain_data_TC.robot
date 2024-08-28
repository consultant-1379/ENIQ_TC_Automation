*** Settings ***
Library    ../../Scripts/check_mws_history_file_contain_data.py


*** Keywords ***
check_mws_history_file_contain_datas
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_mws_history_file_contain_data    ${host}    ${user}    ${pwd}
    [Return]    ${result}


