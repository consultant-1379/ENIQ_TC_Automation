*** Settings ***
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Check status details of ENIQ DWH database using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show status details in ENIQ DWH
    Verify the Dwh_manager status in adminui
    Page Should Contain Element    xpath://*/td[contains(text(),'Services Running')]/font[1][@color='green']
    navigate to database status detils window
    ${Build_time}=    Get Text    xpath://td[text()=' Build Time: ']/following-sibling::td
    Log To Console    ${Build_time}
    Should Not Be Empty    ${Build_time}
    Navigate to main page
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser

