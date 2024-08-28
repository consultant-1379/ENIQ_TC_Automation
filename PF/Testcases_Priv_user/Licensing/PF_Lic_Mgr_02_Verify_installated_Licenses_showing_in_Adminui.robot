*** Settings ***
Documentation     Testing License Status in Adminui web
Library    RPA.Browser.Selenium   
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Licensing_Keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Library    String
Library    Collections
Suite setup       Suite setup steps
Suite Teardown    Suite teardown steps
Test Teardown    Logout from Adminui


*** Test Cases ***
Verify installed licenses showing in Adminui webpage
    Set time delay
    Launch the AdminUI page in browser
    Verify the Adminui Login page is displayed
    Login To Adminui
    Click Show Installed license link
    ${adminui_installed_features}=    Get Installed license features list displayed in webpage

    #installed license features in server
    Open connection as root user
    ${server_installed_features}=    Get license Installed features list in privileged user server
    Verify Installed licenses features list in Admniui webpage is present in server    ${server_installed_features}    ${adminui_installed_features}

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots  

Suite teardown steps
    Close All Browsers
    Close All Connections
     




   
    

    
    
