*** Settings ***
Documentation     Verify Functionality of Reset Button in NR App coverage
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

Functionality of Reset Button
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_02        NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	Check for the error notification is not present
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    NR Cell Performance
	Click on the scroll down button    3    2
	make a selection on the Worst Performing Cells chart
	read the marked value
	click on the button    Home
	verify the page title    Home
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	verify the page title    NR Cell Performance
	verify that the marked value is 0
	Capture page screenshot
	[Teardown]    Test teardown
 	
 	