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

Verifying Node Troubleshooting-PRB Analysis Navigation
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_5
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Click on the button with text    PRB Detailed Analysis
	Verify the page title    PRB: Detailed Analysis
	Click on the button with text    Filtered Data >>
	Verify the page title    PRB: Filtered Raw Data
	Click on the button with text    << PRB Detailed Analysis
	Verify the page title    PRB: Detailed Analysis
	Click on the button with text    << Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Click on the button with id    HomeButton
	Verify the page title    Home