*** Settings ***
Documentation     Validate Functionality of Services Comparison Page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/VoLTEWebUI.robot
Resource	      ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Set Screenshot Directory    ./Screenshots

***Test Cases***

Validate Functionality of Home Page
    open volte analysis
	Go to home page if not already at home
	click on the scroll down button    0    20 
	click on VoLTE Reset button
    click on button title    Services Comparison
    validate page title as    Service Comparison
    Go to home page if not already at home
    click on the scroll down button    0    20 
    click on button title    VoLTE Monitor
    validate page title as    VoLTE Monitor
    click on Home button if not in volte home page
	click on the scroll down button    0    20 
	click on button title    Settings
    validate page title as    Settings
    Capture page screenshot
    [Teardown]    Test teardown