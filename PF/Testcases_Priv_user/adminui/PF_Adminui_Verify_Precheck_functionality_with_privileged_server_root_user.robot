*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    OperatingSystem
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers


*** Test Cases ***
Verify the services in pre check functionality with privileged server root user
    [Tags]    AdminUI
    Click on pre check link under feature vision manager
    Wait Until Page Contains Element    //input[@value="Start"]    timeout=40s
    Input Text    //input[@id="username"]    ${priv_root_user}
    Enter root password    precheckpassword    ${priv_root_pwd}
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
    Set webpage selenium speed


Set webpage selenium speed
    Set Selenium Speed    0.5s
