*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_network_service
    ${output}=    Execute Command    systemctl status network
    [Return]     ${output}

