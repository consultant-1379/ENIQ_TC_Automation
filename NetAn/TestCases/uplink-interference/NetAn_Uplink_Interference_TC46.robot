*** Settings ***
Documentation     Verify filtered data page column details for PRB analysis in node troubleshooting page
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${UplinkInterferenceFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
*** Test Cases ***
Verify filtered data page column details for PRB analysis in node troubleshooting page
    [Tags]         Ran_Uplink_Interference_CDB         Ran_Uplink_Interference_KGB      EQEV-141146
	open uplink interference analysis
	Go to home page if not already at Home
	Click on node troubleshooting button
	select node for filtered data    ERBSG201
	Click on fetch data button
	Click on PRB detailed analysis button
	verify the page title    PRB: Detailed Analysis
	select cell value in PRB analysis page
	select days for filtered data for PRB
	Click on the scroll down button    6    20
	click on Fetch button
	make selection on Select Time Period chart
    Click on filtered data button
	verify the page title    PRB Filtered Raw Data
	Verify if the column is present in the Filtered data page    OSS_ID
	Verify if the column is present in the Filtered data page    UTC_DATETIME_ID
	Verify if the column is present in the Filtered data page    CategoryID
	Verify if the column is present in the Filtered data page    pmRadioRecInterferencePwrPrb
	Verify if the column is present in the Filtered data page    PRB
	Verify if the column is present in the Filtered data page    PRB Interference Power (dBm)
	capture page screenshot