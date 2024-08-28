*** Settings ***
Library    RPA.Browser.Selenium
Resource     ../../Resources/Keywords/Variables.robot
Resource     ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot

*** Test Cases ***
Verify the counter volume status when we start DWH database using adminui
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on button    System Status
    ${IsElementVisible}=    Run Keyword And Return Status     alert should be present    Alert Text: Engine is set to NoLoads
    Run Keyword If    ${IsElementVisible}    handle alert    accept
    Click Link    Counter Volume Information
    Verify the counter volume information in Adminui
    Click on scroll down
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
  
Test teardown
    Capture Page Screenshot
    Close Browser   

    