*** Settings ***
Library    ../Scripts/check_mws_history_file_contain_data.py
Resource    ../Resources/Keywords/verify_mws_history_file_contain_data_TC.robot
Library    CryptoLibrary    variable_decryption=True
Variables    ../Resources/Variables/Variables.py

Test Teardown    teardown tasks

*** Keywords ***
teardown tasks

    Run Keyword If Test Failed    log    File dont contain data
    Run Keyword If Test Passed    log    File do contain data

*** Test Cases ***
check if mws history file contain data

    ${result}=    check_mws_history_file_contain_datas    ${mwshost}    ${mwsuser}    ${mwspwd}
    Should Contain    ${result}    True



