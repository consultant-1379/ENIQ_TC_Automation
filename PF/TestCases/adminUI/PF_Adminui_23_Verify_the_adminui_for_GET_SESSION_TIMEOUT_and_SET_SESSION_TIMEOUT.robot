*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Library    RPA.Browser.Selenium
Library    DateTime
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Test Teardown    Close All Connections


*** Test Cases ***
Verify the adminui for GET_SESSIONS_Timeout and SET_SESSIONS_Timeout
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    ${session}=    Execute the command    ${Get_sessions_timeout}
    Vaildating the number session_timeout   ${User_session_timeout}
    ${session}=    Execute the command    ${Set_sessions_timeout}
    Execute the command    ${Session_timeout_min}
    Vaildate the user session timeout    ${User_session_timeout}
    Launch the AdminUI page in browser
    Login to Adminui
    Verify the Adminui Homepage is displayed
    Setting the time in adminui page    ${Session_timeout_min}
    Reload Page
    Verify the Adminui Login page is displayed
    #Verify the Adminui Log
    Go to the folder    ${sw_log}
    ${current_date}=    Get current date in dd.mm.yyyy result_format
    ${grepError_results}=    Grep message from file    error    user_management_${current_date}.log
    verify for no errors in logs    ${grepError_results}
    Test teardown


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
    
Test teardown
    Capture Page Screenshot
    Close Browser