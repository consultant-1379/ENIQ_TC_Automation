*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_domain_name
    ${output}=    Execute Command    cat /etc/resolv.conf
    [Return]     ${output}

