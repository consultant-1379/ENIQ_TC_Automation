*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_NaviCLI_version
    ${output}=    Execute Command    rpm -qa | grep NaviCLI
    [Return]     ${output}

