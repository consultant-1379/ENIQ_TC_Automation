*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers

*** Test Cases ***
Verify the Adminui Homepage links in ENM Interworking 
    Click on link    Granularity Configuration
    Verify the Granularity Configuration page displayed
    Click on link    Custom Nodes
    Verify the Custom Nodes page displayed
    Click on link    Role Assignment Tool
    Verify the Role Assignment Tool page displayed
    Click on scroll down button
    [Teardown]    Logout from Adminui 

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
    Launch the AdminUI page in browser
    Login to Adminui

 