*** Settings ***
Documentation     Verifying The Latest the Upto 7days Chart For 'Mean UL PDCP UE Throughput' Kpi
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Library			  Process
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/${LTEKPIDashboardKeywordsFile}
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verifying The Latest the Upto 7days Chart For 'Mean UL PDCP UE Throughput' Kpi
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	Click on the scroll down button    0   25
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	clear the Selected KPIs
	${KPI}=    add the KPI to selected KPIs    Mean UL PDCP UE Throughput
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	Click on the scroll down button    4   20
	click on button    KPI Details
	verify the page title    KPI Details
	Make selection on worst performing cells(latest rop) chart
	Verify that 'Up to 7 Days' chart is visible