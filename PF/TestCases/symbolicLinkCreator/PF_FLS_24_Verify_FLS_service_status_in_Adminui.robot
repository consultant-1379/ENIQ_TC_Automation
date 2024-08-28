*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    RPA.Browser.Selenium   
Library    SSHLibrary
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/FLS_keywords.robot
Suite setup       Suite setup steps
Suite teardown    Test teardown steps


*** Test Cases ***
Verify status of fls in AdminUI Webpage
    Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    Login To Adminui
    Click Link    Certificate Expiry Details
    Verify validity of fls license in adminUI Webpage
    



*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown steps
    Capture Page Screenshot
    Logout from Adminui if logged in
    Close Browser


