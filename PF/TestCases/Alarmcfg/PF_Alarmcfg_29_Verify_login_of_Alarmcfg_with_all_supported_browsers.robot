*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify login of Alarmcfg with all supported browsers
    #Default browser is chrome
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Login with valid credentials
    Logout Alarmcfg webpage
    Close All Browsers
      
    # Login with Firefox browser
    Launch the Alarmcfg webpage in Firefox browser    ${login_almcfg_url}   
    Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Login with valid credentials
    Logout Alarmcfg webpage
    [teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
Test teardown
    Capture Page Screenshot
    Close All Browsers
    
