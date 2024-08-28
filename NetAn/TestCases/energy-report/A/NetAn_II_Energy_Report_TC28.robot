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

Verify Energy Usage Functionality - Chart 'Energy Consumption – pmConsumedEnergy'
	[Tags]     Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button value    Energy Usage
	verify the page title   Energy Usage (7 Days)
	select a RAT
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	verify that the Energy Consumption – pmConsumedEnergy has data