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

Verify Energy Saving Features - Selected Cell Visuals
	[Tags]     Energy_Report_CDB
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
	verify that the list box is visible    Energy saving feature(s)
	verify that the list box is visible    Node(s)
	Click on the scroll down button    6   15
	verify that the list box is visible    Cell(s)
	capture page screenshot
	