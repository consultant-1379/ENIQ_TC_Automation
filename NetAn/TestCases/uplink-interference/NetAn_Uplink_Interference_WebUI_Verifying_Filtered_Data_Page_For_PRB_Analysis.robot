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

Verify Filtered Data Page For PRB Analysis
	open uplink interference analysis
	Go to home page if not already at home
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	select Interference Measure and Aggregation as    Interference Power    Average
	click the button    PRB Analysis
	verify the page title    PRB Analysis
	make selection on the PRB chart
	click the button     PRB Detailed Analysis >>
	verify the page title    PRB: Detailed Analysis
	select node for filtered data    ERBS2-1
	select days for filtered data for PRB
	Click on the scroll down button    6    20
	click on Fetch button
	make selection on Select Time Period chart
	click the button    Filtered Data >>
	verify the page title    PRB Filtered Raw Data
	verify that the filtered data page has data
	capture page screenshot
	[Teardown]    Test teardown
 	
 	