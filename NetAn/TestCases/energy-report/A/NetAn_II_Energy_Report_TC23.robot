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

Verify Energy Usgae Energy Saving Features Second Graph Functionality
	[Tags]          Energy_Report_CDB    Energy_Report_KGB
	Click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title    Energy Usage (7 Days)
	select a RAT
	select an area on the pmdConsumedEnergy chart
	click on button    Energy Saving Features >>
	sleep    15
	verify the page title    Energy Saving Features - Node Detail
	select an Energy Saving Feature after Energy Usage
	Click on the scroll down button    6   15
	select Node(s) after Energy Usage
	select an area on Energy saving feature usage per node
	verify that the marked value is not 0
	verify that the button is visible    Home