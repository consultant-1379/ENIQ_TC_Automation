*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify login with removed user
    [Tags]    Adminui
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}    
    Execute the command    ${Tomcat_add_user}
    Execute the command    ${Newuser_id}
    Create new user for Adminui login
    Launch the AdminUI page in browser
    Verify the adminui page in Login page section    ${Password_id}
    Click on scroll down button
    Logout from Adminui
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_remove_user}
    Execute the command    ${Newuser_id}
    Deleting the newly created user
    Launch the AdminUI page in browser
    Login To Adminui with credentials    ${Newuser_id}    ${password_id}
    Validate the update message    ${LoginFailedMsg}   

    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs    ${grepError_results}
    Test teardown

*** Keywords ***    
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
Test teardown
    Capture Page Screenshot
    Close Browser