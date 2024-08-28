*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_networkmanager_status
    ${output}=    Execute Command    systemctl status NetworkManager
    [Return]     ${output}

