*** Settings ***
Library    ../resources/checkupgradespace_MWS.py


*** Keywords ***
check_upgrade_space_MWS
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_memory_space    ${host}    ${user}    ${pwd}
    [Return]    ${result}
