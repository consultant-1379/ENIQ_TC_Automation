*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_efi
    ${output}=    Execute Command    df -h|grep efi
    [Return]     ${output}

