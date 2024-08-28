*** Settings ***
Documentation     Testing Monitoring web
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify at which interval the update monitoring set is running
    Launch the AdminUI page in browser
    Login to Adminui
    Click on link    ETLC Set Scheduling
    Select the set type and package name
    Click on link    ${update_monitoring}
    Verify the DWH_MONITOR page is displayed
    Sleep    5s
    ${Logged successful}=    Get Text    //tr//td[contains(text(),"Logged") and contains(text(),"successful") and contains(text(),"set") and contains(text(),"execution")]
    Log To Console    ${Logged successful}
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser