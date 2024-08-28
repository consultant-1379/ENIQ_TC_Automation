*** Settings ***
Library    SSHLibrary
Variables    ../Variables/variables_for_robot.py

*** Keywords ***
check_nfs_service
    ${output}=    Execute Command    systemctl status ${nfs}
    [Return]     ${output}

