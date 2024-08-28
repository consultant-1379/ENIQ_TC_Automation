*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify Alarmcfg login with Incorrect Username
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${almcfg_sys}    ${incorrect_username}    ${almcfg_pass}    ${almcfg_auth}
    Click Login Button
    Verify Homepage is not displayed
    # mitigation steps for login with incorrect username testcase
    # Input Alarmcfg Login Details    ${almcfg_sys}    ${almcfg_user}    ${almcfg_pass}    ${almcfg_auth}
    # Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    # Logout Alarmcfg webpage 
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close All Browsers