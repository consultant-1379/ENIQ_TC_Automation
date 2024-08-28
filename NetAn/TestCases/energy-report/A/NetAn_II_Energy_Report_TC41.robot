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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot


*** Test Cases ***

Verify Network Summary Functionality
	[Tags]     Energy_Report_KGB    Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button    Network Summary
	verify the page title    Network Summary
	select a tile in Select Energy Consumed
	select Total Downlink Volume
	select an area on Energy consumption per date
	verify that the marked value is not 0
	select an area on Uplink volume, downlink volume per date
	verify that the marked value is not 0