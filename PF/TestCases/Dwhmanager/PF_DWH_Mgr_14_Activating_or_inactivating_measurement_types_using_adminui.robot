*** Settings ***
Documentation     Testing DWHManager web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot

*** Test Cases ***
Activating or inactivating measurement types using adminui
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Click on type configuration
    Select Techpack
    Select Techlevel
    Sleep    5s
    ${active_status}=    Run Keyword And Return Status    Element Should Contain    //table[@border="1"][1]    INACTIVE
    Log To Console    ${active_status}
    IF    ${active_status} == True
        ${Inactive_Typename}    Get Text    //td[text()='INACTIVE']/preceding-sibling::td[2]
        Sleep    2s
        Click on etlc set history and verify msg
        Click Link    //a[text()='Loader_${Inactive_Typename}']
        Table Should Contain    //table[2]    WARNING    
        Table Should Contain    //table[2]    Set loaded in total 0 rows.
    ELSE
        Log To Console    No inactive status is present
    END
    Logout from Adminui


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
Test teardown
    Capture Page Screenshot
    Close Browser

