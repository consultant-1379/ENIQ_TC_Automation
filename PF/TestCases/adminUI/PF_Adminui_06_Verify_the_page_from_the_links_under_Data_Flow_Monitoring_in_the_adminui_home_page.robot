*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui


*** Test Cases ***
Verify the Adminui Homepage links in Data Flow Monitoring  
    Click on link    Show Loadings
    Verify the Show Loadings page displayed
    Click on link    Show Aggregations
    Verify the Show Aggregations page displayed
    Click on link    Reaggregation
    Verify the Reaggregation page displayed
    Click on link    Session Logs
    Verify the Session Logs page displayed    
    Click on scroll down button


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
    Launch the AdminUI page in browser
    Login to Adminui
