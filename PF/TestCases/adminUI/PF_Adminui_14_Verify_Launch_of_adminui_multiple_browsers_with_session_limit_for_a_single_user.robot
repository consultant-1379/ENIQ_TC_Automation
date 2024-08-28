*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Library    String
Library    Collections
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Test Teardown    Close All Connections


*** Test Cases ***
Verify Launch of adminui multiple browsers with session limit for a single user
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${Installer_path}
    ${sessionCountDetails}=    Execute the command    ${Get_sessions_script}
    ${sessionCount}=    Get the session count    ${sessionCountDetails}
    Vaildate the number of Logon sessions    ${Logon_session_msg}
    ${Set session}=    Execute the command    ${Set_sessions_script}
    Execute the command    1
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    Vaildating webserver restart    Webserver restarted successfully    
    Launch the AdminUI page in browser
    Login to Adminui
    Sleep    5s
    Launch the AdminUI page in Firefox browser
    Login To Adminui in firefox
    Vaildating the AdminUI page    Maximum session limit
    Close Browser
    Switch Browser    1
    Click on scroll down button
    Logout from Adminui
    #Setting the sessions limit back to previous session limit
    Go to the folder    ${installer path}
    ${Set session}=    Execute the command    ${Set_sessions_script}    
    Execute the command    ${sessionCount}    
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser
    Close All Connections

        