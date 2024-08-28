*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_ERICkickstart
    ${output}=    Execute Command    rpm -qa|grep ERICkickstart
    [Return]     ${output}

