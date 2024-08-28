*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_UnisphereCLI_version
    ${output}=    Execute Command    rpm -qa | grep UnisphereCLI
    [Return]     ${output}

