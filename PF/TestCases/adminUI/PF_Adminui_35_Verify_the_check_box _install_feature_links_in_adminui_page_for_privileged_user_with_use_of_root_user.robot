*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify check box install feature links in adminui page for privileged user with use of normal root user
    [Tags]    Adminui
    Connect to physical server as root user
    Execute the command    ${privileged_script}    
    Execute the command    ${Enable ENIQ Privileged User}
    Execute the command    1
    Execute the command   ${non_rootuser}
    Enter the password    ${non_rootpass}
    Sleep    10s
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Click on link    Install Features
    Verify the checkbox install feature links and install the feature    ${root_user}    ${root_pwd}  
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots

Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections
    