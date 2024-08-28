*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Licensing_keywords.robot    
Suite setup    Suite setup steps


*** Test Cases ***
Verify adminui status when license gets expired 
    Launch the AdminUI page in browser
    Login to Adminui
    Click Button    System Status
    Verify the System Status page displayed
    Logout from Adminui
    Connect to server as a dcuser
    verify License server and License manager should be in red color when expired
    [Teardown]	Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory	./Screenshots  
    
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections