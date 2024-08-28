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

Verifying Health Check-PUSCH Filtered Data Page
	[Tags]    NR_Uplink_Interference_CDB    NRUI_TC_18
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Click on the scroll right button    2    6
	Adjust the slider to 30 cells
	Make selection on Worst Cells chart for    PUSCH
	Click on the button with text    PUSCH Analysis
	Verify the page title    PUSCH Analysis
	Select Interference Measure and Aggregation as    Interference Power    Maximum
	Select first 10 cells in 'Select Cells for Comparison' list box
	Click on the scroll down button    5    10
	Click on the button with value    Fetch Data
	Click on the button with text    PUSCH Detailed Analysis
	Verify the page title    PUSCH : Detailed Analysis
	Select cells on 'Select Cells for Comparison' list box
	Select days on the 'DAYS' calendar chart for PUSCH
	Make a selection on the 'PUSCH per Date/Time' chart
	Click on the button with text    Filtered Data >>
	Verify the page title    PUSCH : Filtered Raw Data
	Verify that the marked rows are not 0