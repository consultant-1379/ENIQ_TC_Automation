*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the error msg for password with space
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer_path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser_id}
    ${output}=    Enter the password    ${password_with_space}        
    Validating the password   ${output}    ${space}
    [Teardown]    Test teardown

*** Keywords ***
Test teardown
    Close Connection

