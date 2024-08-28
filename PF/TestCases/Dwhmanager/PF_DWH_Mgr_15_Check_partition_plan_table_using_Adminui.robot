*** Settings ***
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Check partition plan tables using Adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click on DWH configuration
    Page Should Contain    Time Based Partition    Volume Based Partition
    Sleep    2s
    Page Should Contain Element    //font[contains(text(),"Time Based Partition")]
    Page Should Contain Element    //font[contains(text(),"Volume Based Partition")]
    Logout from Adminui
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser




