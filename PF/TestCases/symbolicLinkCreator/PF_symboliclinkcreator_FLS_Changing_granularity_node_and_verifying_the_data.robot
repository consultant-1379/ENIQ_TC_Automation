*** Settings ***
Library    RPA.Browser.Selenium
Library    RPA.Windows
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/symboliclinkcreator_FLS_keywords.robot
Suite setup       Suite setup steps
Library           Selenium2Library

*** Test Cases ***
Checking Granularity configuration
    [Tags]    FLS
    Launch the AdminUI page in browser for ${Login_AdminUI_URL_6082}
    Login To Adminui
    Change Granularity and verifyng the querying of data
    [Teardown]    Test teardown

*** Keywords ***
Change Granularity and verifyng the querying of data
    clicking the Granularity configuration from menu bar
    Logout From Adminui
    
Suite setup steps
    Selenium2Library.Set Screenshot Directory   ./Screenshots
Test teardown
    Selenium2Library.Capture page screenshot
    Selenium2Library.Close Browser
    
   



   


