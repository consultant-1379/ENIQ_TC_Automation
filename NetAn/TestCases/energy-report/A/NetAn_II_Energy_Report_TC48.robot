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

Verify Network Summary Visuals
	[Tags]     Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button    Network Summary
	verify the page title    Network Summary
	verify that the table is visible    Total energy consumed
	verify that the table is visible    Total downlink volume
	verify that the table is visible    Total uplink volume
	verify the graph title is present    Energy consumption per date
	verify the graph title is present    Uplink volume, downlink volume per date