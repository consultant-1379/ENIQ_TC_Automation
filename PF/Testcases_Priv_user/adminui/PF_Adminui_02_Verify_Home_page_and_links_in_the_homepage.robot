*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui    


*** Test Cases ***
Verify the Adminui Homepage 
    Verify the Adminui Homepage is displayed
    Verify the All Subcategories in Adminui Homepage is displayed     


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui
