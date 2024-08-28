*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_cached_ERICstorconfig_package
    [Arguments]    ${host}    ${user}    ${pwd}
    Open Connection    ${host}
    Login    ${user}    ${pwd}    delay=1
    ${output}=    Execute Command    ls ${cached_path_to_ERICstroconfig}
    [Return]     ${output}

