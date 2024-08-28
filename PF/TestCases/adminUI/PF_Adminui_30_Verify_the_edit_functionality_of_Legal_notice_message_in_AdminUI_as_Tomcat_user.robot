*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Test Teardown    Close All Connections


*** Test Cases ***
Verify the edit functionality of Legal notice message in AdminUI as Tomcat user
    [Tags]    Adminui
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_add_user}
    Execute the command    ${Newuser_id}
    Verify the login of adminui with newly created tomcat user
    Launch the AdminUI page in browser
    ${Legal Notice Message}=    Get the Legal Notice msg    ${Legal_message_xpath}
    Sleep    2s 
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box 
    Editing the Legal notice msg    ${New_legal_notice}
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${New_legal_notice}
    Logout from Adminui
    Execute the command    cd ${Webapps_path}
    ${Legal_msg_cli}=    Execute the command    cat ${Message_properties}
    Validating the file    ${Legal_msg_cli}    ${New_legal_notice}
    Launch the AdminUI page in browser
    Validate the update message    ${New_legal_notice}
    Sleep    5s
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Click on scroll down button
    Click on link    Legal Notice Message
    Wait for Legal notice page input text box
    Editing the Legal notice msg    ${Legal Notice Message}   
    Click Button    Save
    Validate the update message    ${Legal_sucessfully_msg}
    Verify the Adminui Legal Notice message    ${Legal Notice Message}
    Logout from Adminui
    Go to the folder    ${Installer_path}
    Execute the command    ${Tomcat_remove_user}
    Execute the command    ${Newuser_id}
    Deleting the newly created user
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${Newuser_id}    ${Password_id}
    Validate the update message    ${LoginFailedMsg}
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections