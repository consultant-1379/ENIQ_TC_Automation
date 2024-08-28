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

Verifying 'MRR Cell Comparison Overview Histogram' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	change the View to    Editing
	change to page navigation to    Titled tabs
	click on the button    Select page
	click on MRR Cell Comparison Overview Histogram button
	validate the page title    MRR Comparison Overview Histogram
	verify that 'Select Measure' is visible
	Click on the scroll down button    4    15  
	verify that 'Select Cell' is visible
	verify that 'Select Channel Group' is present
	Capture page screenshot
	[Teardown]    Test teardown
	
	
	
	