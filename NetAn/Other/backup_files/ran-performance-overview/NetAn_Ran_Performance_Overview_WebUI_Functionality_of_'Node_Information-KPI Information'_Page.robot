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

Functionality of 'Node: KPI Information' Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Node Information
	verify the page title    Node Information
	select the KPI    Initial E-RAB Establishment SR (%)
	select a node
	verify that the title of the map is    Initial E-RAB Establishment SR (%)
	click on button    Cell Coverage >>
	verify the page title    Node: Cell Coverage
	click on button    KPI Information >>
	verify the page title    Node: KPI Information
	select a KPI for KPI Information    DL Latency
	verify that the graph heading contains    DL Latency
	KPI summary for 24-hours and Month is visible    DL Latency   
	[Teardown]    Test teardown
 	
 	