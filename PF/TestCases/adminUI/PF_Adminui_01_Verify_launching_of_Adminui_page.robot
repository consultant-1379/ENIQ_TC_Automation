*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Suite setup       Suite setup steps



*** Test Cases ***
Verify launching of Adminui page
    Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Test teardown
    Capture Page Screenshot
    Close Browser





    
    
