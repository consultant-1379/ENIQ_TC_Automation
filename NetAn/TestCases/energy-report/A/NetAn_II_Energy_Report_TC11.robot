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

Verify Energy Meter Visuals
	[Tags]     Energy_Report_CDB
	click on Reset All Filters and Markings button
	click on button value    Energy Usage
	verify the page title   Energy Usage (7 Days)
	click on the scroll down button    4    15
	select a RAT
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	click on Energy Meters >> button
	sleep    120
	verify the page title    Energy Meters (7 Days)
	validate the graph title    Energy meters - pmConsumedEnergy
	verify that the button is visible    Home
	validate that the button is visible    << Energy Usage
	