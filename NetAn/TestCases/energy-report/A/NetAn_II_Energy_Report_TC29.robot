*** Settings ***

Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${EnergyReportKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify Energy Usage Functionality - Chart 'Top 100 Nodes Data Volumes: Downlink and Uplink'
	[Tags]     Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button value    Energy Usage
	verify the page title   Energy Usage (7 Days)
	select a RAT
	verify 'Top 100 nodes - Data Volumes: Downlink and Uplink' graph is visible