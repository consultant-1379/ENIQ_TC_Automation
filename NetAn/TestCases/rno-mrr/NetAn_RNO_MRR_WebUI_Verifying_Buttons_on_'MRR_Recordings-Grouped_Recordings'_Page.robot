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

Verifying Buttons on 'MRR Recordings - Grouped Recordings' Page
	open rno-mrr analysis
	Go to home page if not already at home
	verify the page title    GSM Optimisation Reports
	click on the scroll down button    0    25
	click on button    MRR
	verify the page title    MRR Recordings - Single Recording
	select recordings for    BAA01
	enter the group name    Group1
	click on button    Create group
	sleep    60
	Click on the scroll down button    2    5
	verify that the Grouped Recordings is created    Group1
	click on button    Grouped recordings
	verify the page title    MRR Recordings - Grouped Recordings
	verify that the created group is present    Group1
	validate that the button is visible    Remove Grouping
	validate that the button is visible    Load Data
	select a group    Group1
	click on button    Load data
	verify that the selected group is loaded    Group1
	click on button    Remove grouping
	verify that the group is deleted    Group1
	Capture page screenshot
	[Teardown]    Test teardown