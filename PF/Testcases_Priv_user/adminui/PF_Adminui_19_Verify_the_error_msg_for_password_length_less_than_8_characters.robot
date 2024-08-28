*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the error msg for password length less than 8 characters.
    [Tags]    Adminui 
    #Connect to physical server as prilveleged-user
    #Switching to root user
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser_id}
    ${output}=    Enter the password   ${four_letters_character}
    Validating the password   ${output}    ${eight_character}
    [Teardown]    Test teardown

*** Keywords ***  
Test teardown
    Close Connection   