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

Verify Hardware Overview - Unit Details Functionality - Chart 'Consumed Energy - Selected Unit(s)'
	[Tags]     Energy_Report_CDB    EQEV-115772
	click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title    Energy Usage (7 Days)
	select RAT(s)
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	click on Hardware and Software Overview >> button
	verify the page title    Hardware and Software Overview - Energy
	select Hardware Type(s)
	verify that 'Consumed energy per node per hardware' chart is visible
	make selection on 'Consumed energy per node per hardware' chart
	click on button    Hardware Overview >>
	verify the page title    Hardware Overview - Unit Details
	select the Node(s)
	select Hardware Type(s)
	verify that 'Consumed energy per unit' chart is visible
	make selection on 'Consumed energy per unit' chart
	verify that 'Consumed energy - selected unit(s)' chart is visible