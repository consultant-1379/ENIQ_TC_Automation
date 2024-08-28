*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify the Adminui Homepage
    Connect to server as a dcuser
    Verify the tomcat user creation    ${USERNAME}    ${PASSWORD}
    Increasing the adminui sessions
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on scroll down button
    Click on scroll up button
    Verify the All Subcategories in Adminui Homepage is displayed
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
  
Test teardown
    Capture Page Screenshot
    Close Browser
