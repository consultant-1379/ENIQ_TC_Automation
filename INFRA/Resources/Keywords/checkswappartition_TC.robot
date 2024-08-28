*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_swap
    ${output}=    Execute Command    cat /proc/swaps
    [Return]     ${output}

