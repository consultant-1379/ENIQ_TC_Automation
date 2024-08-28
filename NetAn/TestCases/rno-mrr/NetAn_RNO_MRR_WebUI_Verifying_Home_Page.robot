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

Verifying the Home Page
	open rno-mrr analysis
	Go to home page if not already at home
	network analytics logo should be visible
	rno-mrr logo should be visible
	click on the scroll down button    0    25
	validate that the button is visible    Settings
	validate that the button is visible    MRR
	click on button    Settings
	verify the page title    Settings
	click on the button    Home
	verify the page title    GSM Optimisation Reports
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	click on the button    Home
	verify the page title    GSM Optimisation Reports
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	