*** Settings ***
Force Tags    suite
Library    SSHLibrary
Library    Collections
Library    String
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Installer.robot
Resource    ../../Resources/Keywords/Variables.robot

*** Test Cases *** 
Verification of Installation of the techpack using tp_installer script
    [Tags]    Installer
    Cli.Connect to server as a dcuser
    verify Techpack Installation using tp_installer script

*** Keywords ***
Verify Techpack Installation using tp_installer script
    ${Features}=    Execute Command    ${mws_path_list_of_features}
    ${mws_path}=    Execute Command    ${mws_path_list_of_modules}${Features}/eniq_techpacks/ ; ls
    @{interface}=    Split To Lines    ${mws_path}
    ${Techpack_list}=    Get From List    ${interface}    5
    Go to the folder    ${installer_folder}
    ${installation_status_of_techpack}=    Execute the Command    ${install_techpack_command}${Techpack_list}
    Verify the Techpack installation    ${installation_status_of_techpack}    Techpack Installation Complete    Already stage file available
    [Teardown]    Test teardown

Test teardown
    Close Connection
