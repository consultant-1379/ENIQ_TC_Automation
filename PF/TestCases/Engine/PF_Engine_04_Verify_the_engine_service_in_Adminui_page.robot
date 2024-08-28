*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource     ../../Resources/Keywords/Engine.robot
Resource     ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify the engine service in Adminui page 
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Click on Engine Status link
    Switch window to new Engine status details tab
    Click on scroll down button
    Verify the engine service in AdminUI page
    Switch window to back to Adminui tab
    Click on scroll down button
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
Test teardown
    Capture Page Screenshot    
    Close Browser

