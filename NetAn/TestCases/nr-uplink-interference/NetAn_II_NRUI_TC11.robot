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

Verifying Health Check-PRB Analysis Page Charts for Maximum Interference Power
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_11
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Click on the scroll right button    2    6
	Adjust the slider to 30 cells
	Make selection on Worst Cells chart for    PRB
	Click on the button with text    PRB Analysis
	Verify the page title    PRB Analysis
	Verify the chart names on Health Check-PRB/PUSCH Analysis
	Select Interference Measure and Aggregation as    Interference Power    Maximum
	Verify that the charts on Health Check-PUSCH/PRB Analysis are named for    Interference Power    Maximum
	Select first 10 cells in 'Select Cells for Comparison' list box
	Click on the scroll down button    5    8
	Click on the button with value    Fetch Data
	Make selection on 'per Selected Cell' chart
	Verify that the marked value is not 0