*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_named_service
    ${output}=    Execute Command    systemctl status ${named}
    [Return]     ${output}

