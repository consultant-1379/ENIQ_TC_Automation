*** Settings ***
Documentation     Testing AdminUI web
Library    SSHLibrary
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Test Teardown    Close All Connections


*** Test Cases ***
Verify login of adminui with create_newuser change_password delete_newuser
    [Tags]    Adminui 
    Connect to server as a dcuser
    Go to the folder    ${installer path}
    Execute the command    ${tomcat_add user}
    Execute the command    ${newuser id}
    Verify the login of adminui with newly created user
    Go to the folder    ${installer path}
    Execute the command    ${tomcat change_password}

    Verify the adminui login page    ${password id}
    Verify the login of adminui with updated password
    Deleting the newly created user
    
*** Keywords ***
Verify the login of adminui with updated password
    Verify the change password in command line    ${password id}
    Verify the adminui login page    ${New password}

Verify the change password in command line
    [Arguments]    ${change password}    
    Enter a Username for which password need to be changed    ${newuser id}
    ${output}=    Enter the password    ${change password}
    Validating the password   ${output}    ${existing matching password} 
    ${output}=    Enter the password    ${New password}
    Validating the password   ${output}    ${updated password}
    #Note : Vaildating webserver restart    $session input
    #Note : session input = 0. No argument passed (Default)
    Vaildating webserver restart    0
    Sleep    10s
    
Verify the adminui login page
    [Arguments]    ${Login password}
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${newuser id}    ${Login password}
    Logout from Adminui
    [Teardown]    Test teardown

Deleting the newly created user
    Go to the folder    ${installer path}
    Execute the command    ${tomcat remove_user}
    Execute the command    ${newuser id}
    ${output}=    Enter the password    ${New password}
    ${output}=    Read    delay=5s
    Validating the password    ${output}    ${removeuser_password check}
    Vaildating webserver restart    0
    Sleep    10s
    Test teardown

Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser