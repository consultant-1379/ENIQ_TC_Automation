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

Verifying labels and units of 'Health Check: PRB Analysis' Page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PRB Analysis
	verify the page title    PRB Analysis
	select Interference measure and Aggregation as    Interference Power    Average
	verify that the charts on PRB Analysis are named for    Interference Power    Average
	select Interference measure and Aggregation as    Interference Power    Maximum
	verify that the charts on PRB Analysis are named for    Interference Power    Maximum
	verify the axis labels on PRB Analysis    Interference Power
	select Interference measure and Aggregation as    Noise Rise    Average
	verify that the charts on PRB Analysis are named for    Noise Rise    Average
	select Interference measure and Aggregation as    Noise Rise    Maximum
	verify that the charts on PRB Analysis are named for    Noise Rise    Maximum
	verify the axis labels on PRB Analysis    Noise Rise
	click the button    PRB Detailed Analysis >>
	verify the page title    PRB: Detailed Analysis
	capture page screenshot
	[Teardown]    Test teardown
 	
 	