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

Verifying Health Check Page Elements
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_7
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Select Interference Measure and Aggregation as    Interference Power    Average
	Click on the scroll right button    2    6
	Adjust the slider to 50 cells
	Verify that the Worst Cells chart is named for the cell count    50
	Click on the scroll left button    2    6
	Verify that the charts on Health Check are named for    Interference Power    Average
	Select Interference Measure and Aggregation as    Interference Power    Maximum
	Verify that the charts on Health Check are named for    Interference Power    Maximum
	Verify the x-axis of the charts on Health Check    Interference Power
	Select Interference Measure and Aggregation as    Noise Rise    Average
	Verify that the charts on Health Check are named for    Noise Rise    Average
	Select Interference Measure and Aggregation as    Noise Rise    Maximum
	Verify that the charts on Health Check are named for    Noise Rise    Maximum
	Verify the x-axis of the charts on Health Check    Noise Rise
	Click on Band and Frequency checkbox
	Click on Channel Bandwidth checkbox