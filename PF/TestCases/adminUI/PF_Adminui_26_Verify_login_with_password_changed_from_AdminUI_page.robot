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
Verify login with password changed from Adminui page
    [Tags]    Adminui 
    Change Password in AdminUI page    ${PASSWORD}    ${change_newPassword}
    Sleep    15s
    
    #Revert the password change
    Change Password in AdminUI page    ${change_newPassword}    ${PASSWORD}  
    
    Connect to server as a dcuser
    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${errorCount}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs     ${errorCount}
    
    
*** Keywords ***
Change Password in AdminUI Page
    [Arguments]    ${oldpwd}    ${newpwd}
    Launch the AdminUI page in browser
    Login To Adminui with credentials    ${USERNAME}    ${oldpwd}
    Click on scroll down button
    Click on link    Change Password
    Enter Input    ${oldPasswordId}    ${oldpwd}
    Enter Input    ${newPasswordId}    ${newpwd}
    Enter Input    ${confirmNewPasswordId}    ${newpwd}
    Select Show Password 
    Click On Submit Button
    Validate the update message    ${paswordChangeMsg}
    Sleep     100s
    Refresh Page Until launch page
    [Teardown]    Test teardown

Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser
    