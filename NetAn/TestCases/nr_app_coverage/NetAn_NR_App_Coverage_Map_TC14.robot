*** Settings ***
Documentation     Verifying 'Cell cite Location' Page
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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Library           ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Libraries/DynamicTestcases.py



*** Test Cases ***
Verifying 'Cell cite Location' Page
	[Tags]    NR_AC_KGB    NetAn_UG_NRAC_14    NR_AC_CDB
	open NR app coverage map analysis
	Go to home page if not already at home
	click on the scroll down button    0    25
	click on the button    Settings
	verify the page title    Settings
	Open Performance target
	Select downlink performance
	Select uplink performance
	Click on submit button
	Navigating to Home
	Sleep    5s
	Click on the scroll down button    0    30
	click on the button    Reset All Filters and Markings
	click on button    Cell Performance
	Select from Uplink/Downlink dropdown	Downlink
	select the performance target		DL Throughput >= 0.10 Mbps
	mark on the "Worst Performing Cells (Ranked by Avg Failed User Sessions)" chart
	click on button    Cell Site Location >>
	verify the page title    NR Cell Site Location
	Validate the Map chart is visible or not 
	click on button    << Cell Performance Ranking
	Check for the error notification is not present
	[Teardown]    Test teardown

 		
 	