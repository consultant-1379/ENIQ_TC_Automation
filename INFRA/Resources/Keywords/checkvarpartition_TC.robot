*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_var
    ${output}=    Execute Command    df -h|grep var
    [Return]     ${output}

