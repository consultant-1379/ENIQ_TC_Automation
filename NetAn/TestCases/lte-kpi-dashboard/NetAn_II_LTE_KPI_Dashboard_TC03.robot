*** Settings ***

Documentation     Verifying list of KPI's in KPI Dashboard selection page to view in KPI Dashbaord page
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

Verifying list of KPI's in KPI Dashboard selection page to view in KPI Dashboard page
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	click on the settings button
	verify the page title    KPI Dashboard Selection Settings
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	click on the button    Home
	verify the page title    Home