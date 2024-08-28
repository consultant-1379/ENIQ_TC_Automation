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

Verifying labels and units of 'Health Check' page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click on the scroll down button    0    2
	select Interference measure and Aggregation as    Interference Power    Average
	verify that the charts are named for    Interference Power    Average
	select Interference measure and Aggregation as    Interference Power    Maximum
	verify that the charts are named for    Interference Power    Maximum
	verify the x-axis of the charts    Interference Power
	select Interference measure and Aggregation as    Noise Rise    Average
	verify that the charts are named for    Noise Rise    Average
	select Interference measure and Aggregation as    Noise Rise    Maximum
	verify that the charts are named for    Noise Rise    Maximum
	verify the x-axis of the charts    Noise Rise
	capture page screenshot
	[Teardown]    Test teardown
 	
 	