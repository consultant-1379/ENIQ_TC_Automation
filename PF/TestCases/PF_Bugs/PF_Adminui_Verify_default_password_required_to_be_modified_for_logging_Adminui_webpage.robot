*** Settings ***
Documentation     Testing AdminUI web
Library    RPA.Browser.Selenium
Library    SSHLibrary
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/Cli.robot
Suite setup       Suite setup steps
Suite Teardown    Close All Browsers 
Test Teardown    Logout from Adminui default webpage if logged in

*** Variables ***
${default_adminui_username}    eniq
${default_adminui_password}    eniq

*** Test Cases ***
Verify default password required to be modified for logging Adminui webpage
    Launch Adminui webpage with default creds
    Login to Adminui with default adminui user and password
    Verify Adminui page contain change default password
    

*** Keywords ***
Suite setup steps
    Set Screenshot Directory    ./Screenshots
