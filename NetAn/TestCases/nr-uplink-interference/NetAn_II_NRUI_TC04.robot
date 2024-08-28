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

Verifying Health Check-PUSCH Analysis Navigation
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_4
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Click on the button with text    PUSCH Analysis
	Verify message asking cell selection on Health Check page
	Make selection on Worst Cells chart for    PUSCH
	Click on the button with text    PUSCH Analysis
	Verify the page title    PUSCH Analysis
	Click on the button with text    PUSCH Detailed Analysis >>
	Verify the page title    PUSCH : Detailed Analysis
	Click on the button with text    Filtered Data >>
	Verify the page title    PUSCH : Filtered Raw Data
	Click on the button with text    << PUSCH Detailed Analysis
	Verify the page title    PUSCH : Detailed Analysis
	Click on the button with text    << PUSCH Analysis
	Verify the page title    PUSCH Analysis
	Click on the button with text    << Uplink Interference Health Check
	Verify the page title    Uplink Interference Health Check
	Click on the button with id    HomeButton
	Verify the page title    Home