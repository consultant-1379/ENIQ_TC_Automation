*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_JUMP
    ${output}=    Execute Command    df -h|grep JUMP
    [Return]     ${output}

