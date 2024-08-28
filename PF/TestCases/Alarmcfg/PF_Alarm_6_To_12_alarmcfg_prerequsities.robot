*** Settings ***
Documentation     Testing alarmcfg
Library    RPA.Browser.Selenium    
Library    SSHLibrary
Library    String
Library    Collections    
Resource    ../../Resources/Keywords/alarmCfg_keywords.robot
Resource    ../../Resources/Keywords/Cli.robot
Resource    ../../Resources/Keywords/Variables.robot
Resource    ../../Resources/Keywords/AdminUIWebUI.robot
Suite Setup    Connect to server as a dcuser
Suite Teardown    Close All Connections


*** Test Cases ***
TC 01 Verify latest alarmcfg module deployed in ENIQ Server
    Open clearcasevobs
    Getting the latest module and Rstate of alarmcfg from clearcase page	
    Getting the latest module and Rstate of alarmcfg from Server

TC 02 Downloading the latest alarmcfg module
    Verifying if latest alarmcfg module is already installed on server
    Downloading latest alarmcfg module if not installed on server

TC 03 Installing the latest alarmcfg module
    Verifying if latest alarmcfg module is already installed on server
    Installing latest alarmcfg module if not installed on server

TC 04 Verifying if alarmcfg latest module is present after installation.
    Verifying if latest alarmcfg module is already installed on server
    Verifying if latest alarmcfg module got installed on server

TC 05 verifying if alarmcfg latest module is present on adminUI page
    Launch the AdminUI page in browser
    Login To Adminui
    Click Link    Monitoring Commands
    Verifying if latest alarmcfg module is present on adminUI page.   
						
TC 06 verifying alarmcfg Log files
    Getting latest alarmcfg log file and verifying no error should be there


    