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

Verification Of 'Health Check: PUCCH/PUSCH Detailed Analysis' Page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	click the button    PUCCH/PUSCH Analysis
	verify the page title    PUCCH/PUSCH Analysis
	click the button    PUCCH/PUSCH Detailed Analysis >> 
	verify the page title    PUCCH/PUSCH: Detailed Analysis
	select the channel as    PUSCH
	select days for filtered data
	click on the scroll down button    4    8
	Click on Fetch button
	verify that the marked value is not 0
	verify that all navigation buttons on PUCCH/PUSCH: Detailed Analysis are working properly
	capture page screenshot
	[Teardown]    Test teardown
 	
 	