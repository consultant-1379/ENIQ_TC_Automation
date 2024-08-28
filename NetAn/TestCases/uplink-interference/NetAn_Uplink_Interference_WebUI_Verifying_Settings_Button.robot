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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verifying Settings button	
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on the button    Settings
	verify the page title    Settings
	validate that the button is visible    Configure MSA
	click on the scroll down button    0    30
	click on the button    Home
	verify the page title    Home
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	