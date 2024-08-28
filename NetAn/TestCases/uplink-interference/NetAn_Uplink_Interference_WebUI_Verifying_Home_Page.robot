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

Verifying Home Page
	open uplink interference analysis
	Go to home page if not already at home
	network analytics logo should be visible
	click on the scroll down button    0    15
	uplink interference logo should be visible
	verify that the button is visible    Reset Filters & Markings
	verify that the button is visible    Settings
	validate that the button is visible    Health Check
	validate that the button is visible    Node Troubleshooting
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click on the button    Home
	verify the page title    Home
	click on the scroll down button    0    15
	click on button    Node Troubleshooting
	verify the page title    Node Troubleshooting
	click on the button    Home
	verify the page title    Home
	click on the scroll down button    0    15
	click on the button    Settings
	verify the page title    Settings
	Click on the scroll down button    0    30
	click on the button    Home
	verify the page title    Home
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	