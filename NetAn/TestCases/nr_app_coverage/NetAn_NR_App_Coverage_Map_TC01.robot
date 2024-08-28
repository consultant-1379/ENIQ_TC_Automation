*** Settings ***
Documentation     Verify Home Page in NR App coverage 
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

Verify the Home Page
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_01       NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	Check for the error notification is not present
	network analytics logo should be visible
	NR app coverage map logo should be visible
	Click on the scroll down button    0    30
	verify that the button is visible    Reset All Filters and Markings
	verify that the button is visible    Settings
	validate that the button is visible    Cell Performance
	validate that the button is visible    Network Overview
	click on the button    Settings
	verify the page title    Settings
	Click on the scroll down button    0    30
	click on the button    Home
	verify the page title    Home
	Click on the scroll down button    0    30
	click on button    Cell Performance
	verify the page title    	NR Cell Performance
	click on the button    Home
	verify the page title    Home
	Click on the scroll down button    0    30
	click on button    Network Overview
	verify the page title    NR Network Overview
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	