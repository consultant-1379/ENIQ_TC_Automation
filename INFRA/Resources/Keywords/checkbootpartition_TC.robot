*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_boot
    ${output}=    Execute Command    df -h|grep boot
    [Return]     ${output}

