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

Navigating to 'Health Check: PUCCH/PUSCH Analysis'	
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis
	click the button    PUCCH/PUSCH Detailed Analysis >> 
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    Filtered Data >>
	verify the page title    PUCCH/PUSCH Filtered Raw Data
	click the button    << PUSCH/PUCCH Detailed Analysis
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	click the button    << PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis
	click the button    \ << Uplink Interference Health Check 
	verify the page title    Uplink Interference Health Check Cell
	click on the button    Home
	verify the page title    Home
	capture page screenshot
	[Teardown]    Test teardown
 	
 	