*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium      
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps

*** Test Cases ***
Verify launching of Alarmcfg page
    Launch the Alarmcfg webpage in browser
    Verify Alarmcfg webpage is displayed
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close All Browsers

