*** Settings ***

Library    SSHLibrary

*** Keywords ***

check_bond_interface
    ${output}=    Execute Command    ip addr show|grep bond
    [Return]     ${output}

