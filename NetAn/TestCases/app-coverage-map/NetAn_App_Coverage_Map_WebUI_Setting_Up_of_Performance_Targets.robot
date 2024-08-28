*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEAppCoverageMapKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verify the Settings button
	open app coverage map analysis
	Go to home page if not already at home
	Click on the scroll down button    0    30
	click on the button    Settings
	verify the page title    Settings
	verify that the Performance Targets section is visible
	configure DL Performance Targets    0.10
	configure UL Performance Targets    3.00
	Click on the scroll down button    0    30
	click on button    Submit
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	