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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verify Filtered Data Page For Health Check: Antenna Branch Analysis
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    Antenna Branch Analysis
	verify the page title    Antenna Branch Analysis
	select Interference measure and Aggregation as    Interference Power    Maximum
	make selection on Worst 100 PUCCH Cells by Interference Power
	click the button    Antenna Branch Detailed Analysis >>
	verify the page title    Antenna Branch: Detailed Analysis
	click on the scroll down button    3    3
	select a node for comparison
	select days for filtered data for PRB
	click on the scroll down button    4    5
	click on Fetch button
	verify that the marked value is not 0
	click the button    Filtered Data >>
	verify the page title    Antenna Branch Filtered Raw Data
	click the button    << Antenna Branch Detailed Analysis
	verify the page title    Antenna Branch: Detailed Analysis
	click the button    Filtered Data >>
	verify the page title    Antenna Branch Filtered Raw Data
	click on the button    Home
	verify the page title    Home
	capture page screenshot
	[Teardown]    Test teardown
 	
 	