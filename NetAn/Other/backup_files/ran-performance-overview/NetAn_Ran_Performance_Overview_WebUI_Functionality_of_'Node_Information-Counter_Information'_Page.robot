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

Functionality of 'Node Information: Counter Information' Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Node Information
	verify the page title    Node Information
	select the KPI    Initial E-RAB Establishment SR (%)
	select a node
	click on button    Cell Coverage >>
	verify the page title    Node: Cell Coverage
	click on button    KPI Information >>
	verify the page title    Node: KPI Information
	select a KPI for KPI Information    Initial E-RAB Establishment SR
	click on button    Counter Information >>
	verify the page title    Node: Counter Information
	select a counter    pmErabEstabAttInit
	verify that the graph heading contains    pmErabEstabAttInit
	KPI summary for 24-hours and Month is visible    pmErabEstabAttInit
	verify that the button is visible    << KPI Information
	verify that the button is visible    Filtered Data >>
	verify that the button is present    Return to Home
	[Teardown]    Test teardown
 	
 	