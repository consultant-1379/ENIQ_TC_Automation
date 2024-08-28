*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_root
    ${output}=    Execute Command    df -h|grep root
    [Return]     ${output}

