*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Busyhourcfg.robot
Suite setup       Suite setup steps

*** Test Cases ***
Verification of busy hour configuration and validate enabling and disabling of place holders
    [Tags]    Busyhourcfg
    Launch the AdminUI page in browser
    Login To Adminui
    Sleep    3s
    Verify Home Page Is Displayed
    click on busy hour configuration link and navigate to busy hour configuration window
    Verifying busy hour configuration page is opened
    select the teckpacks from the dropdown
    click on show button
    click on source techpack link
    verify enabling and disabling of placeholders
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
     
Test teardown
    Capture Page Screenshot
    Close Browser
