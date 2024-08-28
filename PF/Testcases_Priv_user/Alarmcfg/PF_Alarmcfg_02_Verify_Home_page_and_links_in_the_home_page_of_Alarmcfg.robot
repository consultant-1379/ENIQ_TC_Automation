*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium      
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify Home page and links in the home page of Alarmcfg
    Launch the Alarmcfg webpage in browser
    Input Alarmcfg Login Details    ${cdb_almcfg_sys}    ${cdb_almcfg_user}    ${cdb_almcfg_pass}    ${cdb_almcfg_auth}
    Wait Until Keyword Succeeds    2x    5s    Verify Alarmcfg webpage logged in successfully
    Verify the All Subcategories links in Alarmcfg Homepage is displayed 
    Logout Alarmcfg webpage
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser