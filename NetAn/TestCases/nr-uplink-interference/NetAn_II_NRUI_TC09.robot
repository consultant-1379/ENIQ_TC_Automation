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

Verifying Health Check Page Worst Cells Charts for Average Interference Power
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_9
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Health Check
	Verify the page title    Uplink Interference Health Check
	Select Interference Measure and Aggregation as    Interference Power    Average
	Click on the scroll right button    2    6
	Adjust the slider to 30 cells
	Make selection on Worst Cells chart for    PUSCH
	Verify that the marked value is not 0
	Make selection on Worst Cells chart for    PRB
	Verify that the marked value is not 0