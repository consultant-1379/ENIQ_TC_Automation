*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_multiuser_service
    ${output}=    Execute Command    systemctl status ${multiuser}
    [Return]     ${output}

