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

Functionality of Reset button
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	make selection on the Worst 500 Cells chart
	read the marked value
	click on the button    Home
	verify the page title    Home
	click on the scroll down button    0    15
	click on the button    Reset Filters & Markings
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	verify that the marked value is 0
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	