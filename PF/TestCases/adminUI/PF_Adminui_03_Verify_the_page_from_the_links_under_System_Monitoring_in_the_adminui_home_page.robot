*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers    



*** Test Cases ***
Verify the Adminui Homepage links in System Monitoring 
    Click Button    System Status
    Verify the System Status page displayed
    Click on link    ETLC Monitoring
    Verify the ETLC Monitoring page displayed
    Click on link    ETLC Set History
    Verify the ETLC Set History page displayed
    Click on link    ETLC Set Scheduling
    Verify the ETLC Set Scheduling page displayed
    Click on link    Monitoring Commands
    Verify the Monitoring Commands page displayed
    Click on link    TechPack Installation
    Verify the TechPack Installation page displayed
    Click on link    FM Alarm
    Verify the FM Alarm page displayed  
    Click on scroll down button
    [Teardown]    Logout from Adminui if logged in

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui


