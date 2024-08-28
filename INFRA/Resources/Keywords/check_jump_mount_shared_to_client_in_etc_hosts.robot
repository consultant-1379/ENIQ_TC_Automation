*** Settings ***
Library    ../../Scripts/verify_client_ips_in_etc_hosts_file.py


*** Keywords ***
check_client_ips_in_etc_hosts_file
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    clients_in_etc_hosts    ${host}    ${user}    ${pwd}
    [Return]    ${result}