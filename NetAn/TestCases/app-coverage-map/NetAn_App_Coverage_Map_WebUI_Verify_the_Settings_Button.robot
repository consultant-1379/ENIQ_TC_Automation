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
	Click on the scroll down button    0    30
	open MSA Configurations
	verify that the MSA Configuration section is visible
	Click on the scroll down button    0    30
	verify that the button is visible    Home
	click on the button    Home
	verify the page title    Home
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	