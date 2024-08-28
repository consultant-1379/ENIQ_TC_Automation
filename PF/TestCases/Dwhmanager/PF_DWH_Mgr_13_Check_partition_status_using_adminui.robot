*** Settings ***
Documentation     Testing DWHmanager
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
Check partition status as "ACTIVE" using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click on type configuration
    Selecting the techpack
    Selecting the Techlevel
    Sleep    2s
    ${Count}    Get Element Count    //table[@border="1"]//tr[@style]
    Page Should Contain Element    //table[@border="1"]//tr/td[@class="basiclist" and text()]/following-sibling::td[text()='ACTIVE']    limit=${Count}    message=Some elements are not in ACTIVE state
    Logout from Adminui
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser


        
    
