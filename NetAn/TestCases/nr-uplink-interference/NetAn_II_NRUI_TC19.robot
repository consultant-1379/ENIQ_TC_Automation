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

Verifying Node Troubleshooting Page Elements
	[Tags]    NR_Uplink_Interference_KGB    NR_Uplink_Interference_CDB    NRUI_TC_19
	Open NR Uplink Interference analysis
	Go to Home page if not already at home    #remove
	Click on the scroll down button    0    10
	Click on the button    Reset Filters & Markings    #remove
	Click on the button with value    Node Troubleshooting
	Verify the page title    Node Troubleshooting
	Verify the default selections on Node Troubleshooting page
	Select Interference Measure and Aggregation as    Interference Power    Average
	Select Interference Measure and Aggregation as    Interference Power    Maximum
	Verify that the charts on Node Troubleshooting are named for    Interference Power
	Verify the axes of the charts on Node Troubleshooting    Interference Power
	Select Interference Measure and Aggregation as    Noise Rise    Average
	Select Interference Measure and Aggregation as    Noise Rise    Maximum
	Verify that the charts on Node Troubleshooting are named for    Noise Rise
	Verify the axes of the charts on Node Troubleshooting    Noise Rise
	Select a node from the Node List
	${node_name}=    read the selected node in the Node List
	Click on the scroll down button    3    26
	Click on the button with value    Fetch Data
	Verify that the Node Troubleshooting page is named for    ${node_name}