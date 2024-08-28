*** Settings ***
Documentation     Testing DWHmanager
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Check connection information of dwhrep in ENIQ REP database using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show connection status details in ENIQ REP
    navigate to DWHREP IQ connection status details window
    Sleep    2s
    ${dwhrep_details}=    Get Text    xpath://td[text()='dwhrep']/following-sibling::td
    Log To Console    ${dwhrep_details}
    Should Not Be Empty    ${dwhrep_details}
    Navigate to main page
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser

