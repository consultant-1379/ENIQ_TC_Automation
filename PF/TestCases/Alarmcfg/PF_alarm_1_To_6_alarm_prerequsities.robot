*** Settings ***
Documentation     Testing alarm
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/AlarmCfg_keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections


*** Test Cases ***
TC 01 Verify latest alarm module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of alarm from clearcase page	
    Getting the latest module and Rstate of alarm from Server

TC 02 Downloading the latest alarm module
    Verifying if latest alarm module is already installed on server
    Downloading latest alarm module if not installed on server

TC 03 Installing the latest alarm module
    Verifying if latest alarm module is already installed on server
    Installing latest alarm module if not installed on server

TC 04 Verifying if alarm latest module is present after installation.
    Verifying if latest alarm module is already installed on server
    Verifying if latest alarm module got installed on server

TC 05 verifying if alarm latest module is present on adminUI page
    Launch the AdminUI page in browser
    Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest alarm module is present on adminUI page.   
						
TC 06 verifying alarm Log files
    Getting latest alarm log file and verifying no error should be there


    