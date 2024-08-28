*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_EMC_repo
    ${output}=    Execute Command    ls /etc/yum.repos.d/
    [Return]     ${output}

