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

Verify Filtered Data Page For Antenna Branch Analysis
	open uplink interference analysis
	Go to home page if not already at home
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	select Interference Measure and Aggregation as    Interference Power    Average
	click the button    Antenna Branch Analysis
	verify the page title    Antenna Branch Analysis
	make selection on the Antenna Branch Analysis chart
	click the button      Antenna Branch Detailed Analysis >>
	verify the page title    Antenna Branch: Detailed Analysis
	select node for filtered data    1
	select days for filtered data for Antenna Branch Analysis
	Click on the scroll down button    4    20
	click on Fetch button
	make selection on Select Time Period chart
	click the button    Filtered Data >>
	verify the page title    Antenna Branch Filtered Raw Data
	verify that the filtered data page has data
	capture page screenshot
	[Teardown]    Test teardown
 	
 	