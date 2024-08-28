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

Verify The Data Is Shown For 'E-RAB Retainability - Percentage Lost per QCI' KPI In KPI View - Node Page
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	click on reset filters and markings button
	click on Node View button
	select a KPI on KPI view - Node page    E-RAB Retainability - Percentage Lost per QCI
	click on Refresh Data button
	make selection on Selected Nodes chart
	verify that the marked value is not 0
	make selection on Upto 7 Days chart
	verify that the marked value is not 0