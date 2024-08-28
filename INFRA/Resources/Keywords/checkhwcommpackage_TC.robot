*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_hwcomm_package
    ${output}=    Execute Command    rpm -qa|grep hwcomm
    [Return]     ${output}

