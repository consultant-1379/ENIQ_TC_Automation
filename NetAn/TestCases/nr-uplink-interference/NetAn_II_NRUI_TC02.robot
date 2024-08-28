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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${NRUplinkInterferenceKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verifying Reset Filters & Markings Functionality
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_2
	Open NR Uplink Interference analysis
	Verify the page title    Home
	Click on the scroll down button    0    10
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Make selection on Worst Cells chart for    PUSCH
	Verify that the marked value is not 0
	Click on the button with id    HomeButton
	Verify the page title    Home
	Click on the scroll down button    0    10
	Verify that the button is visible    Reset Filters & Markings
	Click on the Reset Filters & Markings button
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Verify that the marked value is 0