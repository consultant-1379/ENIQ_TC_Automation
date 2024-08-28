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

Verify Energy Saving Features - Selected Cell Functionality
	[Tags]     Energy_Report_KGB    Energy_Report_CDB    ER_KGB         s14
	click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title    Energy Usage (7 Days)
	select a RAT
	select an area on the pmdConsumedEnergy chart
	click on button    Energy Saving Features >>
	sleep    15
	verify the page title    Energy Saving Features - Node Detail
	click on button    Cell Details >>
	validate the graph title    Energy saving feature usage per cell
	select nodes and cell values
	select an area on the energy saving usage cell chart
	verify that the bottom graph has data
	verify that the button is visible    Home
	validate that the button is visible    << Node Details
	capture page screenshot
	