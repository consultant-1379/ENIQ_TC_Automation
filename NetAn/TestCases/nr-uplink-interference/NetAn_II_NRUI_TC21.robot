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

Verifying Node Troubleshooting Page Charts for Maximum Noise Rise
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_21
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Select Interference Measure and Aggregation as    Noise Rise    Maximum
	Select a node from the Node List
	Click on the scroll down button    3    26
	Click on the button with value    Fetch Data
	Make selection on 'per Cell' chart for    PUSCH
	Verify that the marked value is not 0
	Make selection on 'per Cell by Date/Time' chart for    PUSCH
	Verify that the marked value is not 0
	Make selection on 'per Cell' chart for    PRB
	Verify that the marked value is not 0
	Make selection on 'per Cell by Date/Time' chart for    PRB
	Verify that the marked value is not 0