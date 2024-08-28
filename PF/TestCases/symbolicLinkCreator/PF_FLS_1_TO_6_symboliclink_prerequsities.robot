*** Settings ***
Documentation     Testing Symboliclinkcreator
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/FLS_keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Test Setup    Connect to server as a dcuser
Test Teardown    Close All Connections


*** Test Cases ***
TC 01 Verify latest fls module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of fls from clearcase page	
    Getting the latest module and Rstate of fls from Server

TC 02 Downloading the latest fls module
    Verifying if latest fls module is already installed on server
    Downloading latest fls module if not installed on server

TC 03 Installing the latest fls module
    Verifying if latest fls module is already installed on server
    Installing latest fls module if not installed on server

TC 04 Verifying if fls latest module is present after installation.
    Verifying if latest fls module is already installed on server
    Verifying if latest fls module got installed on server

TC 05 verifying if fls latest module is present on adminUI page
    Launch the AdminUI page in browser
    Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest fls module is present on adminUI page.   
						
TC 06 verifying fls Log files
    Getting latest fls log file and verifying no error should be there


    