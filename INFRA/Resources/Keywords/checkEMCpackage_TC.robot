*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_EMC_package
    ${output}=    Execute Command    rpm -qa|grep EMC
    [Return]     ${output}

