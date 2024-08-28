*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verification Of Interference Health Check Page
	open uplink interference analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Health Check
	verify the page title    Uplink Interference Health Check
	All input panels should be present
	click on the scroll down button    2    10
	verify that Cell/Branch drop down is visible and select Cell
	verify that Band and Frequency check box is visible
	verify that Channel Bandwidth check box is visible
	verify the button is visible    Antenna Branch Analysis
	verify the button is visible    PRB Analysis
	verify the button is visible    PUCCH/PUSCH Analysis
	verify that all navigation buttons are working
	capture page screenshot
	[Teardown]    Test teardown
 	
 	