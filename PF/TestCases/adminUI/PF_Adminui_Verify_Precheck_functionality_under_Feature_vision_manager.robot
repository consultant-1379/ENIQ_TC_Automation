*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers


*** Test Cases ***
Verify the services in pre check functionality
    [Tags]    AdminUI
    Click on pre check link under feature vision manager
    Run Keyword And Return Status    Click on button    ${Finish_button}
    Enter root password    precheckpassword    ${root_pwd}
    Click on button    Start
    Wait Until Precheck Summary Report is displayed
    Verifying services status in pre check link
    Click on button    ${Finish_button}
    [Teardown]    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    Launch the AdminUI page in browser
    Login to Adminui
    Verify Home Page Is Displayed
    
Test teardown
    Capture Page Screenshot
    Close Browser