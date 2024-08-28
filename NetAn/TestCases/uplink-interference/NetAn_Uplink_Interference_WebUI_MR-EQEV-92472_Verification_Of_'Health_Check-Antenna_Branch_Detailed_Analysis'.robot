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

Verification Of 'Health Check: Antenna Branch Detailed Analysis' Page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    Antenna Branch Analysis
	verify the page title    Antenna Branch Analysis
	click the button     \ Antenna Branch Detailed Analysis >>
	verify the page title    Antenna Branch: Detailed Analysis
	select days for filtered data on Health Check: Antenna Branch Detailed Analysis
	click on the scroll down button    4    10
	click on Fetch button
	verify that all navigation buttons on Health Check: Antenna Branch Detailed Analysis are working properly
	capture page screenshot
	[Teardown]    Test teardown
 	
 	