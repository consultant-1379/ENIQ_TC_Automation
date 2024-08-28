*** Settings ***
Library    SCPLibrary
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/ebsmanager.robot
Suite setup       Suite setup steps

*** Test Cases ***
verification of ebs upgrader functionality is Running 
    [Tags]    ebsmanager
    #It will work only in Vapp servers 
    connect to winscp
    Place the mom file in ebs folder
    Launch the AdminUI page in browser for ${vapp_url}
    Login To Adminui
    Verify Home Page Is Displayed
    click on EBS Upgrader link
    click on upgrade now button
    click on Details button
    Verifying ebs upgrader status is Running
    Logout from Adminui
    [Teardown]    Test teardown

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
    
Test teardown
    Capture Page Screenshot
    Close Browser