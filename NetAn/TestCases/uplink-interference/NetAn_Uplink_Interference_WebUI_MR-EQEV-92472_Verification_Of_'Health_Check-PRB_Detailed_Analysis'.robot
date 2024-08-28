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

Verification Of 'Health Check: PRB Detailed Analysis' Page	
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PRB Analysis
	verify the page title    PRB Analysis
	click the button     \ PRB Detailed Analysis >>
	verify the page title    PRB: Detailed Analysis
	select days for filtered data on PRB: Detailed Analysis
	click on the scroll down button    6    10
	click on Fetch button
	verify that the marked value is not 0
	verify that all navigation buttons on PRB: Detailed Analysis are working properly
	capture page screenshot
	[Teardown]    Test teardown
 	
 	