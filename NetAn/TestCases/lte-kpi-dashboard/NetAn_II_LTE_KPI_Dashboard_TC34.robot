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

Verifying The Latest ROP Value For 'Initial E-RAB Establishment Success Rate for Emergency Calls' KPI
	[Tags]     LTE_KPI_CDB    LTE_KPI_KGB
	open lte kpi dashboard analysis
	go to home page if not at home
	Click on the scroll down button    0   25
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	clear the Selected KPIs
	add 'Initial E-RAB Establishment Success Rate for Emergency Calls' KPI to selected KPIs
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	${latestROPValue}=    read the Latest ROP value for selected KPI
	${sql_query}=    get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/lte-kpi-dashboard/LTE_KPI_Dashboard_DataIntegrity.json     TC_34
	${DB_Value}=    Query Sybase database    ${sqlQuery}
	Match UI with DB Value    ${latestROPValue}    ${DB_Value}