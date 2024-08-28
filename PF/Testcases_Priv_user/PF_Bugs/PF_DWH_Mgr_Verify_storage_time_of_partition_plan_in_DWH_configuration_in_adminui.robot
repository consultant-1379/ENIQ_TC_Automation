*** Settings ***
Documentation     Testing DWHManager web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Dwhmanager.robot
Suite Setup    Suite setup steps  
Suite Teardown    Close All Browsers
Test Teardown    Logout from Adminui      


*** Test Cases ***
Verify Storage time of partition plan in DWH configuration in Adminui  
    Click on dwh configuration for privileged user    ${root_user}    ${root_pwd}
    Click partition plan column link and update storage time


*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots 
    Launch the AdminUI page in browser
    Login To Adminui
    Verify Home Page Is Displayed
    Set webpage selenium speed   
  


