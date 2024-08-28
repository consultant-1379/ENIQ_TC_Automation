*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify check box in update features links in adminui page
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC_PM_Tech_Pack}
    Click on scroll down
    Click on button    Continue    
    Enter root password    ${Eniqs_password_input_id}    ${root_pwd}
    Click on button    Update
    sleep    20min
    Vaildating the AdminUI page    Feature Update Overview - UPDATE SUCCESSFUL    
    Vaildating the AdminUI page    COMPLETED
    Enter root password    commitpassword   ${root_pwd}
    Click on button    ${Commit_button}    
    Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
    Sleep    2min
    Vaildating the AdminUI page    This site can’t be reached
    Sleep    5min
    Reload Page
    Verify the Adminui Login page is displayed
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser