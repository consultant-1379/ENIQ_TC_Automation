*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Check the connection information of adminui in ENIQ DWH database using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show connection status details in ENIQ DWH
    navigate to IQ Connection status details window
    Page Should Contain    AdminUI    dc
    Page Should Contain    AdminUI    DBA
    Navigate to main page
    Logout from Adminui
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser

