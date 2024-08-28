*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify that custom user details in the adminui page
    Connect to server as a dcuser
    Verify the tomcat user creation    ${custom user}    ${custom pwd}
    Launch the AdminUI page in browser
    Login To Adminui with New credentials    ${custom user}    ${custom pwd}
    Click on scroll down button
    Click on link    	Customized Database User Details
    Vaildate the user details page
    Logout from Adminui
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  
Test teardown
    Capture Page Screenshot
    Close Browser
