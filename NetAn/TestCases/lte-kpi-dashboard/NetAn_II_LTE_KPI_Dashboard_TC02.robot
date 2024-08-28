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

Verifying Settings Page
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	Click on the scroll down button    0   15
	click on the button    Home
	verify the page title    Home
	Click on the scroll down button    0   15
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	click on the button    Home
	verify the page title    Home