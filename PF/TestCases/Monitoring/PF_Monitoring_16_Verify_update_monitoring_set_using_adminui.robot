*** Settings ***
Documentation     Testing Monitoring web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Monitoring.robot
Resource    ../ebsmanager/PF_ebsmanager_verifying_ebs_upgrader_functionality_status_is_Running.robot

*** Test Cases ***
Verify the update monitoring set using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click on ETLC set History link
    Select package name as DWH_MONITOR
    Sleep    2s
    ${Success_msg}    Get Text    //tr//td[contains(text(),"Logged") and contains(text(),"successful") and contains(text(),"set") and contains(text(),"execution")]
    Log To Console    ${Success_msg}
    Logout from Adminui

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser
    
   