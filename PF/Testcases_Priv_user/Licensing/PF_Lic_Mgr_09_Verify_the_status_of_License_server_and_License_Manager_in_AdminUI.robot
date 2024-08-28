*** Settings ***
Documentation     Testing License Status in Adminui web
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_Keywords.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify status of License Server and License Manager
    Set time delay
    Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    Login To Adminui
    Verify module status is displayed in webpage    License server    Green
    Verify module status is displayed in webpage    License manager    Green
    Logout from Adminui
    [Teardown]    Test teardown


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser









    
    
