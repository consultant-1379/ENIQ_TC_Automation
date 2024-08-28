*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui

*** Test Cases ***
Verify user manual link Adminui Homepage
    [Tags]    AdminUI
    Verify Home Page Is Displayed
    Click on scroll down button
    Click on user manual link
    Navigate to usemanual page
    Verifying user manual page is opened
    Navigate to main page

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui
    