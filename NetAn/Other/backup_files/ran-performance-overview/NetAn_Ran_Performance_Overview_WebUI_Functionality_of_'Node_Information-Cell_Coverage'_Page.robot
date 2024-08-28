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

Functionality of 'Node: Cell Coverage' Page
	open ran performance lte overview analysis
	Go to home page if not already at home
	click on the scroll down button    0    15
	click on the button    Reset All Filters and Markings
	click on button    Node Information
	verify the page title    Node Information
	select the KPI    Initial E-RAB Establishment SR (%)
	select a node
	verify that the title of the map is    Initial E-RAB Establishment SR (%)
	click on button    Cell Coverage >>
	verify the page title    Node: Cell Coverage
	verify that the button is visible    << Node Information
	verify that the button is visible    KPI Information >>
	verify that the button is present    Return to Home
	[Teardown]    Test teardown
 	
 	