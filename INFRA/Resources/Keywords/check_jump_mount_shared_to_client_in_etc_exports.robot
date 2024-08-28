*** Settings ***
Library    ../../Scripts/verify_client_ips_in_etc_exports_file.py


*** Keywords ***
check_client_ips_in_etc_export_file
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    clients_in_etc_exports    ${host}    ${user}    ${pwd}
    [Return]    ${result}