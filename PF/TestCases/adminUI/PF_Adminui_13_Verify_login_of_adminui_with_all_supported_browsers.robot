*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify login of adminui with all supported browsers
    #Default browser is chrome
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on scroll down button
    Click on scroll up button
    Verify the All Subcategories in Adminui Homepage is displayed
    Logout from Adminui
    Launch the AdminUI page in Firefox browser
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
    
