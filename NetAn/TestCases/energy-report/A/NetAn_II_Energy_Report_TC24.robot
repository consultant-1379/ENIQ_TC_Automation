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

Verify Energy Saving Features - Visuals
	[Tags]     Energy_Report_CDB         Energy_Report_KGB
	Click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title    Energy Usage (7 Days)
	select a RAT
	select an area on the pmdConsumedEnergy chart
	click on button    Energy Saving Features >>
	sleep    15
	verify the page title    Energy Saving Features - Node Detail
	validate the graph title    Nodes by energy consumption, downlink and uplink volume  
	validate the graph title    Energy saving feature usage per node(s)
	verify that the button is visible    Home
	capture page screenshot