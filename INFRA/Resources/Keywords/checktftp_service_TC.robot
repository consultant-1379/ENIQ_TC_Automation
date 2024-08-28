*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_tftp_service
    ${output}=    Execute Command    systemctl status ${autofs}
    [Return]     ${output}

