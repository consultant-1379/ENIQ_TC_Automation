*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_autofs_service
    ${output}=    Execute Command    systemctl status ${autofs}
    [Return]     ${output}

