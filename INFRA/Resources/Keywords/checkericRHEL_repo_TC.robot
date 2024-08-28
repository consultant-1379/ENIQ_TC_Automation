*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_ericRHEL_repo
    ${output}=    Execute Command    cat /etc/yum.repos.d/ericRHEL.repo|grep baseurl
    [Return]     ${output}

