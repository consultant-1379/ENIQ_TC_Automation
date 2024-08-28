*** Settings ***
Library    ../resources/checkupgradespace.py


*** Keywords ***
check_upgrade_space
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_memory_space    ${host}    ${user}    ${pwd}
    [Return]    ${result}
