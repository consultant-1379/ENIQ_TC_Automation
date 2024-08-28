*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_etc_hosts
    ${output}=    Execute Command    cat /etc/hosts
    [Return]     ${output}

