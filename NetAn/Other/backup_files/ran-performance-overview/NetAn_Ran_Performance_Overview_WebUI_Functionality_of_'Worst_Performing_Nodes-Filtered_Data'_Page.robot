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

Functionality of 'Worst Performing Nodes: Filtered Data' Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on button    Worst Performing Nodes
	verify the page title    Worst Performing Nodes
	select the KPI    Initial E-RAB Establishment SR (%)
	make selection in worst performing nodes
	click on button    Cell Coverage >>
	verify the page title    Worst Performing Nodes: Cell Coverage
	click on button    KPI Information >>
	select a KPI for KPI Information    E-RAB Retainability
	click on button    Counter Information >>
	verify the page title    Worst Performing Nodes: Counter Information
	select a counter    pmErabEstabAttInit
	KPI summary for 24-hours and Month is visible    pmErabEstabAttInit
	click on button    Filtered Data >>
	verify the page title    Worst Performing Nodes: Filtered Data
	verify that table is visible for the selected nodes
	[Teardown]    Test teardown
 	
 	