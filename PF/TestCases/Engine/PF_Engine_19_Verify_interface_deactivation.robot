*** Settings ***
Library    SSHLibrary
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot



*** Test Cases ***
Verify the interface deactivation
    Connect to physical server
    Go to the folder    ${installer_path}
    Remove log file
    Write    ./get_active_interfaces | grep -i eniq_oss_1
    ${getting_activing_interfaces}=    Read    delay=1s
    @{interface}=    Split To Lines    ${getting_activing_interfaces}
    ${Techpack_list}=    Get From List    ${interface}    1
    ${Techpack_selected_01}=    Executing the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list}
    Verify the msg    ${Techpack_selected_01}    Starting to deactivate interfaces
    ${Techpack_selected_02}=    Executing the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list}
    Verify the msg    ${Techpack_selected_02}    already deactivated

*** Keywords ***
Test Teardown
    Close All Connections   
