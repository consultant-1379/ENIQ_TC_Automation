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

Verify Historical Trend Visuals
	[Tags]     Energy_Report_CDB
	Click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title   Energy Usage (7 Days)
	select a RAT
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	click on button value    Historical Trend >>
	verify the page title    Historical Trend
	validate the page header as Energy Usage (Historical View - Up to 6 months)
	validate the graph title    Consumed energy measurement - pmConsumedEnergy
	validate the graph title    Data volume - downlink and uplink
	verify that the table is visible    Summary of energy usage
	verify that the table is visible    Summary of data volume