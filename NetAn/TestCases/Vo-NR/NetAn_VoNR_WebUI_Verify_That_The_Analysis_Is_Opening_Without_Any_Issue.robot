*** Settings ***

Documentation     
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/VoNR_Keywords.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Set Screenshot Directory    ./Screenshots

***Test Cases***

Verfify That The Analysis Is Opening Without Any Issues
    open vo-nr analysis
    verify the page title    Home
	Capture page screenshot
    [Teardown]    Test teardown