*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RNO-MRRAnalysisWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verifying 'MRR RECORDINGS >> Landing Page - Single Recordings' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	validate that the button is visible    MRR
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	verify that the button is visible    Home
	verify that the button is visible    Settings
	verify that the button is visible    Refresh
	validate that the button is visible    Create Group
	validate that the button is visible    Load Data
	validate that the button is visible    Grouped Recordings
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	