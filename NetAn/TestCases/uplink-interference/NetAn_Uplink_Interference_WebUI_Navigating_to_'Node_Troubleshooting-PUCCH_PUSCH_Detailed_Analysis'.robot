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

Navigating to 'Node Troubleshooting: PUCCH/PUSCH Detailed Analysis'
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Node Troubleshooting
	verify the page title    Node Troubleshooting
	click the button    PUCCH/PUSCH Detailed Analysis
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    Filtered Data >>
	verify the page title    PUCCH/PUSCH Filtered Raw Data
	click the button    << PUSCH/PUCCH Detailed Analysis
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    << Node Troubleshooting
	verify the page title    Node Troubleshooting
	click on the button    Home
	verify the page title    Home
	capture page screenshot
	[Teardown]    Test teardown
 	
 	