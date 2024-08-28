*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_network_interfaces
    [Arguments]    ${vlan}
    ${output}=    Execute Command    ip addr show|grep ${vlan}
    [Return]     ${output}

