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

Verifying Single Recordings Button on 'MRR Recordings - Grouped Recordings' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	select recordings for    BAA01
	enter the group name    Group1
	click on button    Create group
	click on the scroll down button    2    5
	verify that the Grouped Recordings is created    Group1
	click on button    Grouped recordings
	verify the page title    MRR Recordings - Grouped Recordings
	verify that the created group is present    Group1
	validate that the button is visible    Single Recordings
	click on button    Single recordings
	verify the page title    MRR Recordings - Single Recording
	Capture page screenshot
	[Teardown]    Test teardown