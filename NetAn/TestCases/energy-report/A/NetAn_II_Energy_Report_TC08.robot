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

Verify Network Summary - Hardware Overview Functionality - Chart 'Consumed Energy Vs Node Count Per Hardware'
	[Tags]     Energy_Report_CDB    EQEV-115772
	click on Reset All Filters and Markings button
	click on button    Network Summary
	verify the page title   Network Summary
	click on button    Hardware Overview >>
	verify the page title   Hardware Overview - Network
	select Hardware Type(s) on Network Summary page
	verify that 'Consumed energy vs node count per hardware' chart is visible