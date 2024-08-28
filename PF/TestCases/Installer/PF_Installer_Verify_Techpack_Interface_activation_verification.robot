*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    String
Library    Collections
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot

*** Test Cases *** 
Verify activation of interfaces for multiple eniq aliases
    [Tags]    Installer
    Connect to physical server
    Verify interface activation for eniq_oss_n

*** Keywords ***
Verify interface activation for eniq_oss_n
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_techpacks/ ; ls
    @{interface}=    Split To Lines    ${mws_path}
    ${Techpack_list}=    Get From List    ${interface}    5
    Go to the folder    ${installer_folder}
    Remove log file
    ${activation_status_of_techpack}=    Executing the command    ./activate_interface -o eniq_oss_1 -i${Techpack_list}
    verify activation status of techpack    ${activation_status_of_techpack}    Change profile requested successfully        
    ${interface_status}=    Execute the Command    ${grep_eniq_oss_*}
    verify the interface activation with eniq_oss_n   ${interface_status}    eniq_oss_
    [Teardown]    Test teardown

Test teardown
    Close Connection
