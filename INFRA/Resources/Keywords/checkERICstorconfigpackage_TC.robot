*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_ERICstorconfig_package
    [Arguments]    ${host}    ${user}    ${pwd}
    Open Connection    ${host}
    Login    ${user}    ${pwd}    delay=1
    ${output}=    Execute Command    rpm -qa|grep ERICstorconfig
    [Return]     ${output}

