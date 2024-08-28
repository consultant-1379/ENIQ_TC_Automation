*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify the Adminui Homepage links in Configuration 
    Launch the AdminUI page in browser
    Login to Adminui
    Click on scroll down button
    Click on link    Monitoring Rules
    Click on scroll down button
    Verify the Monitoring Rules page displayed
    Click on link    Monitored Types
    Click on scroll down button
    Verify the Monitored Types page displayed
    Click on scroll down button
    Click on link    Type Configuration
    Click on scroll down button
    Verify the Type Configuration page displayed
    Click on link    DWH Configuration
    Click on scroll down button
    Verify the DWH Configuration page displayed
    Click on link    Logging Configuration
    Click on scroll down button
    Verify the Logging Configuration page displayed
    Click on link    Polling Start Time
    Click on scroll down button
    Verify the Polling Start Time page displayed
    Click on link    EBS Upgrader
    Click on scroll down button
    Verify the EBS Upgrader page displayed
    Click on link    Busy Hour Configuration
    Switch window to new Busyhour tab
    Switch window to back to Adminui tab
    Verify the Busy Hour Configuration page displayed
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
     
Test teardown
    Capture Page Screenshot
    Close Browser
    