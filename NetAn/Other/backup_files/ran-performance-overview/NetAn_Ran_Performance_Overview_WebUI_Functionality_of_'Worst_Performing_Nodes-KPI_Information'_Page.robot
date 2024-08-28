*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           SSHLibrary
Library           DateTime
Library           PostgreSQLDB
Library           SikuliLibrary
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/RanPerformanceOverviewWebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/DataIntegrity_Keywords.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot

*** Test Cases ***

Functionality of 'Worst Performing Nodes: KPI Information' Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Worst Performing Nodes
	verify the page title    Worst Performing Nodes
	select the KPI    Initial E-RAB Establishment SR (%)
	click on button    Cell Coverage >>
	verify the page title    Worst Performing Nodes: Cell Coverage
	click on button    KPI Information >>
	select a KPI for KPI Information    E-RAB Retainability
	verify that the graph heading contains    E-RAB Retainability
	KPI summary for 24-hours and Month is visible    E-RAB Retainability     
	[Teardown]    Test teardown
 	
 	