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

Verifying Node Troubleshooting-PUSCH Detailed Analysis Page Charts
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_24
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Select Interference Measure and Aggregation as    Interference Power    Average
	Select a node from the Node List
	Click on the scroll down button    3    26
	Click on the button with value    Fetch Data
	Click on the button with text    PUSCH Detailed Analysis
	Verify the page title    PUSCH: Detailed Analysis
	Verify the chart names on Node Troubleshooting-PUSCH Detailed Analysis
	Select cells on 'Select Cells for Comparison' list box
	Select days on the 'DAYS' calendar chart for PUSCH
	Make a selection on the 'PUSCH per Date/Time' chart
	Verify that the marked value is not 0
	Verify that 'pmRadioRecInterferencePowerDistr' chart is visible
	Make a selection on the 'pmRadioRecInterferencePowerDistr' chart
	Verify that the marked value is not 0