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

Verify Hardware And Software Overview Functionality - Chart 'Consumed Energy Per Node Per Software'
	[Tags]     Energy_Report_CDB    EQEV-115772        s14
	click on Reset All Filters and Markings button
	click on button    Energy Usage
	verify the page title    Energy Usage (7 Days)
	select RAT(s)
	make selection on Top 100 Nodes with Highest Energy Consumption chart
	click on Hardware and Software Overview >> button
	verify the page title    Hardware and Software Overview - Energy
	select Software Type(s)
	verify that 'Consumed energy per node per software' chart is visible
	make selection on 'Consumed energy per node per software' chart
	click on button    Software Throughput >>
	verify the page title    Software Overview - Throughput
	select the Node(s)
	select Software Type(s)
	make selection on 'Date Volume per Software Chart' chart
	verify that Downlink, uplink volume per software chart is visible