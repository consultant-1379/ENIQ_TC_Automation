*** Settings ***
Documentation     Verify the Settings button in NR App coverage
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRAppKeywords}


*** Test Cases ***

Verify the Settings button
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_03       NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	Check for the error notification is not present
	Click on the scroll down button    0    30
	click on the button    Settings
	verify the page title    Settings
	Open Performance target
	Select downlink performance
	Select uplink performance
	Click on submit button
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	