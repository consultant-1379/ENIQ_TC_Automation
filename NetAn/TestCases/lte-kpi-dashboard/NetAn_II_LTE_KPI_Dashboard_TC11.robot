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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Verifying The Difference Value For 'Mean UL PDCP UE Throughput' KPI
	[Tags]     LTE_KPI_CDB    LTE_KPI_KGB
	open lte kpi dashboard analysis
	go to home page if not at home
	click on reset filters and markings button
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	clear the Selected KPIs
	${KPI}=    add the KPI to selected KPIs    Mean UL PDCP UE Throughput
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	${latestROPValue}=    read the Latest ROP value for the selected KPI
	${differenceROPValue}=    read the difference value for selected KPI
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/lte-kpi-dashboard/LTE_KPI_Dashboard_DataIntegrity.json     TC_10
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	${sql_query1}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/lte-kpi-dashboard/LTE_KPI_Dashboard_DataIntegrity.json     TC_11
	${DB_Value1}=    Query Sybase database    ${sqlQuery1}
	verify that the difference between the two ROP values is correct    ${DB_Value}    ${DB_Value1}    ${differenceROPValue}
	
	
	
	
	
	
	
	
	
	
	