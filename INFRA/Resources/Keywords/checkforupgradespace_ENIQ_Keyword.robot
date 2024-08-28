*** Settings ***
Library    ../../Scripts/checkupgradespace_ENIQ.py


*** Keywords ***
check_upgrade_space_ENIQ
    [Arguments]    ${host}    ${user}    ${pwd}
    ${result}=    check_memory_space    ${host}    ${user}    ${pwd}
    [Return]    ${result}

