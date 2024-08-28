*** Settings ***
Documentation     Testing Monitoring web
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Monitoring.robot
Library    RPA.Browser.Selenium
Library    DateTime
Library    String

*** Test Cases ***
Verify all the DWH_MONITOR sets using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Click on ETLC set History link
    Select yesterday date and package name as DWH_MONITOR
    Select name filter as SessionLoader_Starter and click on search
    Verify 96 rops for SessionLoader_Starter

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser