*** Settings ***

Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRUplinkInterferenceKeywordsFile}

*** Test Cases ***

Verifying Home Page
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_1    
	Open NR Uplink Interference analysis
	Verify the page title    Home
	Verify Network Analytics logo is visible
	Verify NR Uplink Interference logo is visible
	Click on the scroll down button    0    10
	Verify that the button is visible    Reset Filters & Markings
	Click on the button    Reset Filters & Markings
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Click on the button with id    HomeButton
	Verify the page title    Home
	Click on the scroll down button    0    10
	Click on the button with value    Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Click on the button with id    HomeButton
	Verify the page title    Home