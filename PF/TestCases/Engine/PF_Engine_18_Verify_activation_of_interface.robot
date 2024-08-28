*** Settings ***
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Engine.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot


*** Test Cases ***
Verify activation of interface
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    Remove log file
    Set Client Configuration    prompt=[eniq_stats] {dcuser} #:    timeout=900
    ${getting_activing_interfaces_01}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
    @{interface_01}=    Split To Lines    ${getting_activing_interfaces_01}
    ${Techpack_list_01}=    Get From List    ${interface_01}    1
    ${Techpack_selected_01}=    Running the script    ./activate_interface -o eniq_oss_1 -i${Techpack_list_01}
    Verify the msg    ${Techpack_selected_01}    Change profile requested successfully
    ${repdb_return_status}=    Run Keyword And Return Status    Verify eniq_oss_2 is present    
    IF    ${repdb_return_status} == True
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_02}=    Execute the Command    cd /eniq/sw/installer && ./get_active_interfaces | grep -i eniq_oss_2
        @{interface_02}=    Split To Lines    ${getting_activing_interfaces_02}
        ${Techpack_list_02}=    Get From List    ${interface_02}    1
        ${Techpack_selected_02}=    Running the script   ./activate_interface -o eniq_oss_2 -i${Techpack_list_02}
        Verify the msg    ${Techpack_selected_02}    Change profile requested successfully
        ${pm_data}=    Execute the command    cd /eniq/data/pmdata/ ; ls -lrth
        Verify the msg    ${pm_data}    eniq_oss_2
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_03}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
        @{deactive_interface-03}=    Split To Lines    ${getting_activing_interfaces_03}
        ${Techpack_list_03}=    Get From List    ${deactive_interface-03}    1
        ${Techpack_selected_03}=    Execute the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list_03}
        Verify the msg    ${Techpack_selected_03}    Starting to deactivate interfaces 

    ELSE
        Go to the folder    ${installer_path}
        ${getting_activing_interfaces_03}=    Go to the folder    ./get_active_interfaces | grep -i eniq_oss_1
        @{deactive_interface-03}=    Split To Lines    ${getting_activing_interfaces_03}
        ${Techpack_list_03}=    Get From List    ${deactive_interface-03}    1
        ${Techpack_selected_03}=    Execute the command    ./deactivate_interface -o eniq_oss_1 -i${Techpack_list_03}
        Verify the msg    ${Techpack_selected_03}    Starting to deactivate interfaces

    END

*** Keywords ***
Test Teardown
    Close All Connections   
