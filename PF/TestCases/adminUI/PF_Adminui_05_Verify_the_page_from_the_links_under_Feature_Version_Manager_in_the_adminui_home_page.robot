*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui    


*** Test Cases ***
Verify the Adminui Homepage links in Feature Version Manager
    Click on link    Pre Check
    Verify the Pre Check page displayed
    Click on link    Update Features
    Verify the Update Features page displayed
    Click on link    Install Features
    Verify the Install Features page displayed
    Click on link    Report Extraction
    Verify the Report Extraction page displayed
    Click on scroll down button

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui
