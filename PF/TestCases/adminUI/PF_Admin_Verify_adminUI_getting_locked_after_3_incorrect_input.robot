*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers    


*** Test Cases ***
Verify Adminui homepage copyright year
    Launch the AdminUI page in browser
    Repeat Keyword    2    Login To Adminui with invalid password  
    Login To Adminui with invalid passwords
    sleep    3s
    Page Should Contain    3600 seconds
    


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

