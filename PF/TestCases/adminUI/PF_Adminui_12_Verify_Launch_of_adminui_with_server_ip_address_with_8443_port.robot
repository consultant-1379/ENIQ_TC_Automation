*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify Launch of adminui with server ip address with 8443 port
    Launch the Adminui Page in browser with IP Address and port number
    Verify the Adminui Login page is displayed
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
      
Test teardown
    Capture Page Screenshot
    Close Browser