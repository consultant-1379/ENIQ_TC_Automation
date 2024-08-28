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

Verifying the Network View Chart for 'Initial E-RAB Establishment Success Rate for Emergency Calls' KPI
	[Tags]     LTE_KPI_CDB
	open lte kpi dashboard analysis
	go to home page if not at home
	click on reset filters and markings button
	Click on the scroll down button    0   25
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	clear the Selected KPIs
	${KPI}=    add the KPI to selected KPIs    Initial E-RAB Establishment Success Rate for Emergency Calls
	click on button    KPI Dashboard >>
	verify the page title    KPI Dashboard
	Click on the scroll down button    4   10
	click on button    KPI Details
	verify the page title    KPI Details
	Verify that 'Network View (Up to 7 Days)' chart is visible