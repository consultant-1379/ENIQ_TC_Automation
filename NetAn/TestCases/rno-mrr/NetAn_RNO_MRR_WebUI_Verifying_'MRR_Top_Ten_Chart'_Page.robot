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

Verifying 'MRR Top Ten Chart' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	verify that recordings are present in Individual Recordings
	select a recording    BAA01
	click on button    Load data
	sleep    20
	verify that selected recording is loaded    BAA01
	sleep    90
	click on the scroll down button    3    8
	click on button    Overview report
	sleep    90
	verify the page title    MRR Overview Report
	click on button    MRR overview histogram
	verify the page title    MRR Overview Histogram
	click on button    MRR top ten chart
	verify the page title    MRR Top Ten Chart
	verify that 'Filter Measure' is present
	verify that 'Cell Filter' is present
	verify that 'Filter No. of Cells' is present
	Capture page screenshot
	[Teardown]    Test teardown
	
	
	
	