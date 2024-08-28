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

Verifying 'MSMT Export' button on 'MRR Recordings - Single Recording' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	validate that the button is visible    MRR
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	select a recording    BAA01
	click on button    Load data
	sleep    60
	verify that selected recording is loaded    BAA01
	sleep    90
	click on the scroll down button    3    8    
	click on button    Export MSMT
	verify that the file is exported
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	