*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_firewalld_status
    ${output}=    Execute Command    systemctl status firewalld
    [Return]     ${output}

