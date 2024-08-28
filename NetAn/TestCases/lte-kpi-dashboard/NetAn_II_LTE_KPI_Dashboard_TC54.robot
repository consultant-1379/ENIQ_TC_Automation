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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEKPIDashboardKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verify The Data Is Shown For 'UTRAN SRVCC Success Rate' KPI In KPI View - Cell Page
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	click on reset filters and markings button
	click on Node View button
	verify the page title    KPI View - Node
	add 'UTRAN SRVCC Success Rate' KPI to selected KPIs
	click on Refresh Data button
	make selection on Selected Nodes chart
	verify that the marked value is not 0
	make selection on Upto 7 Days chart
	verify that the marked value is not 0
	click on button    KPI View - Cell >>
	verify the page title    KPI View - Cell
	make selection on Cell View chart
	verify that the marked value is not 0
	make selection on Upto 7 Days chart
	verify that the marked value is not 0