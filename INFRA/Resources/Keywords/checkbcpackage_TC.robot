*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_bc_package
    ${output}=    Execute Command    rpm -qa bc
    [Return]     ${output}

