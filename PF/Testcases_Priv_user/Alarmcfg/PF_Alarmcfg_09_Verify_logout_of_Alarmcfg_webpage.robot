*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium      
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify logout of Alarmcfg webpage
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${cdb_almcfg_sys}    ${cdb_almcfg_user}    ${cdb_almcfg_pass}    ${cdb_almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Logout Alarmcfg webpage
    Verify Alarmcfg webpage logged out
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser