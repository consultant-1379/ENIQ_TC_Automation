*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps


*** Test Cases ***
Verify the Launching of adminui with 8080 port
    Launch the Adminui page in browser with IP Address and wrong port number
    Vaildating the AdminUI page    This site can’t be reached    
    [Teardown]    Test teardown
    
*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
      
Test teardown
    Capture Page Screenshot
    Close Browser  