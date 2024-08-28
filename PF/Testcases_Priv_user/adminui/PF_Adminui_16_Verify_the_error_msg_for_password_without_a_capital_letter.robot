*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot


*** Test Cases ***
Verify the error message for password without a capital letter
    [Tags]    Adminui 
    #Connect to physical server as prilveleged-user
    #Switching to root user
    Open connection as root user
    Write    sudo su - dcuser
    ${output}=    Read    delay=1s
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser id}
    ${output}=    Enter the password    ${lower case password}
    Validating the password    ${output}    ${upper_case}
    [Teardown]    Test teardown

*** Keywords ***
Test teardown
    Close Connection
    

        