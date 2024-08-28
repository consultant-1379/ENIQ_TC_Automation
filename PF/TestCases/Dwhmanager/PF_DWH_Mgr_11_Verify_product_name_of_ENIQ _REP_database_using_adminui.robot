*** Settings ***
Documentation     Testing DWHmanager
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Verify product name of ENIQ REP database using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click Button    System Status
    Click on Show status details in ENIQ REP
    Verify Status is displayed    xpath://font[contains(text(),"ENIQ REP")]/parent::td/preceding-sibling::td/img[@alt="Green"]
    Page Should Contain Element    xpath://*/td[contains(text(),'Services Running')]/font[6][@color='green']
    navigate to database status detils window
    ${Product_name}=    Get Text    xpath://td[text()='Product name ']/following-sibling::td
    Log To Console    ${Product_name}
    Validate the output    ${Product_name}    	SQL Anywhere
    Navigate to main page
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser