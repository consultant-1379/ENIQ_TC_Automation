*** Settings ***
Library    SSHLibrary

*** Keywords ***
check_multipathd_status
    ${output}=    Execute Command    systemctl status multipathd
    [Return]     ${output}

