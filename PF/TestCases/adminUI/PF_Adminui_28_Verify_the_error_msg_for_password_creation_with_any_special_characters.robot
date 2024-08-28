*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify the error msg for password creation with any of the below the special characters
    Launch the AdminUI page in browser
    Login To Adminui
    Click on scroll down button
    Click on link    Change Password
    Enter Input    ${oldPasswordId}    ${PASSWORD}
    Enter Input    ${newPasswordId}    ${changePasswordSpecialCharacter}
    Enter Input    ${confirmNewPasswordId}    ${changePasswordSpecialCharacter}
    Select Show Password 
    Click On Submit Button
    Validate the update message    ${changePasswordErrorMsg}
    Logout from Adminui
    [Teardown]    Test teardown
    
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
      
Test teardown
    Capture Page Screenshot
    Close Browser
    