*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui


*** Test Cases ***
Verify the Adminui Homepage links in Data Verification
    Click on link    Data Row Info
    Verify the Data Row Info page displayed
    Click on link    Data Row Summary
    Verify the Data Row Summary page displayed
    Click on link    Show Reference Tables
    Verify the Show Reference Tables page displayed
    Click on link    Busy Hour Information
    Verify the Busy Hour Information page displayed
    Click on link    RANKBH Information
    Verify the RANKBH Information page displayed
    Click on scroll down button

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui
      
Test teardown
    Capture Page Screenshot
    Close Browser