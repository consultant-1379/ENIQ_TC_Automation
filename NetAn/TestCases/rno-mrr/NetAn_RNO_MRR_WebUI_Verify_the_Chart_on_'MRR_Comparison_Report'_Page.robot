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

Verify the Chart on 'MRR Comparison Report' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	change the View to    Editing
	change to page navigation to    Titled tabs
	click on the button    Select page
	click on MRR Comparison Report button
	validate the page title    MRR Comparison Report
	verify that the Comparison chart is visible
	Capture page screenshot
	[Teardown]    Test teardown
	
	
	
	