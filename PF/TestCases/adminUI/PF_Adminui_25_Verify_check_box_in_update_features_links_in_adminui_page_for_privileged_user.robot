*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify check box in update features links in adminui page for privileged user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}        
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command    ${non_rootuser}
    Execute the command    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Update Features
    Select the feature    ${DSC PM Tech Pack}   
    Click on scroll down
    Click on button    Continue
    Enter username and password    ${non_rootuser}    ${non_rootpass}
    Click on button    Update
    sleep    20min
    Vaildating the AdminUI page    Feature Update Overview - UPDATE SUCCESSFUL
    Vaildating the AdminUI page    COMPLETED
    Enter commit username and password    ${non_rootuser}    ${non_rootpass}      
    Click on button    ${commit button}    
    Vaildating the AdminUI page    Feature Commit Overview - FEATURE COMMIT IN PROGRESS
    Sleep    2min
    Vaildating the AdminUI page    This site can’t be reached
    Sleep    5min
    Reload Page
    Verify the Adminui Login page is displayed
    Close Browser
    Sleep    10s
    Connect to physical server as non-root user
    Execute the command    su - root
    Execute the command    ${root_pwd}
    Execute the command    ${privileged_script}
    Execute the command    ${Rollback ENIQ Privileged User}
    ${Rollback_msg}=    Execute the command    y
    Verify the msg    ${Rollback_msg}    Successfully completed Rollback Admin group stage
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections