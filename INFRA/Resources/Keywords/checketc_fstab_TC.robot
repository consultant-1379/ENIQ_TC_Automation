*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_etc_fstab_JUMP
    ${output}=    Execute Command    cat /etc/fstab|grep -c JUMP
    [Return]     ${output}

