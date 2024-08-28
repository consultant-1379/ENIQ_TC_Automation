*** Settings ***
Documentation     Testing Alarmcfg Webpage
Library    RPA.Browser.Selenium     
Resource    ../../Resources/Keywords/Alarmcfg_keywords.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify Launch of Alarmcfg url with invalid port
    Launch Alarmcfg url with invalid port
    Verify message is displayed    This site can’t be reached 
    [Teardown]    Test teardown
   
    
*** Keywords ***  
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close All Browsers