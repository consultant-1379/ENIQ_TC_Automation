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

Verifying Node Troubleshooting-PRB Filtered Data Page
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_23
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value   Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Select Interference Measure and Aggregation as    Interference Power    Average
	Select a node from the Node List
	Click on the scroll down button    3    26
	Click on the button with value    Fetch Data
	Click on the button with text    PRB Detailed Analysis
	Verify the page title    PRB: Detailed Analysis
	Select cells on 'Select Cells for Comparison' list box
	Select days on the 'DAYS' calendar chart for PRB
	Make a selection on the 'Select Time Period(s)' chart
	Click on the button with text    Filtered Data >>
	Verify the page title    PRB: Filtered Raw Data
	Verify that the marked rows are not 0