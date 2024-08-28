*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps

*** Test Cases ***
Verify the Feature Version Manager Report extraction
    [Tags]    AdminUI
    Launch the AdminUI page in browser
    Login to Adminui
    Verify Home Page Is Displayed
    Click on scroll down button
    Click on link    Report Extraction
    Verify the Report Extraction page displayed
    Click on button    Extract Package
    Run Keyword And Return Status    Handle Alert
    Verify the Report Extraction error
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser