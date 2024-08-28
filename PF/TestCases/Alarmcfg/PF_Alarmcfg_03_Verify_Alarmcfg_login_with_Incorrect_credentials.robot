*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium      
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps

*** Test Cases ***
Verify Alarmcfg login with Incorrect credentials
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${incorrect_system}    ${incorrect_username}    ${incorrect_password}    ${incorrect_auth}
    Click Login Button
    Verify Homepage is not displayed 
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close All Browsers