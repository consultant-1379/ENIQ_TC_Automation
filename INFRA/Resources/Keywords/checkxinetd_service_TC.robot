*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_xinetd_service
    ${output}=    Execute Command    systemctl status ${xinetd}
    [Return]     ${output}

