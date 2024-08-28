*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_Hyperic_package
    ${output}=    Execute Command    rpm -qa|grep Hyperic
    [Return]     ${output}

