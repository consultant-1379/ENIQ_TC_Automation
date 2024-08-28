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



*** Test Cases ***
Verify the adminui for GET_SESSIONS and SET_SESSIONS
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    ${sessionCountDetails}=    Execute the command    ${Get_sessions script}
    ${sessionCount}=    Get the session count    ${sessionCountDetails}
    Vaildate the number of Logon sessions    ${Logon_session_msg}
    ${Set_session}=    Execute the command    ${Set_sessions script}
    Execute the command    2
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Launch the AdminUI page in Firefox browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Logout from Adminui
    Close Browser
    Switch Browser    1
    Click on scroll down button
    Sleep    2s
    Logout from Adminui
    #Setting the sessions limit back to previous session limit
    Go to the folder    ${installer path}
    ${Set_session}=    Execute the command    ${Set_sessions script}
    Execute the command    ${sessionCount}
    Vaildate the number of Logon sessions updated    ${Logon_session_updated_msg}
    [Teardown]    Test teardown
    

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
    
Test teardown
    Capture Page Screenshot
    Close Browser     
