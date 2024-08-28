*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify precheck link in adminui page by providing dcuser credentials 
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
    Click on link    Pre Check
    Enter Precheck username and password    ${user_for_vapp}    ${pass_for_vapp}
    Click on button    Start
    Page Should Contain    Incorrect Username or password
    Logout from Adminui
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
