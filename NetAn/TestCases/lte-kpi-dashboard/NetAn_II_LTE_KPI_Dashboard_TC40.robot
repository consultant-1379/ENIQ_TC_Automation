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

Verifying The Functionality of Node View Button in Home Page
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	verify the page title    Home
	Click on the scroll down button    0   25
	Click on the scroll right button    0   38
	click on button    Node View
	verify the page title    KPI View - Node