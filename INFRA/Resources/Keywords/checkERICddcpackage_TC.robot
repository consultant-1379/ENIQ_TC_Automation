*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_ERICddc_package
    ${output}=    Execute Command    rpm -qa|grep ERICddc
    [Return]     ${output}

