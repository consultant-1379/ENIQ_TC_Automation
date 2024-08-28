*** Settings ***
Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/NR_KPI_Dashboard_WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verifying "Node View" Page
	open nr kpi dashboard
	Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    Refresh
	click on button    Node View
	verify the page title    Node View
	select node    ERBS1
	select nodes on the map
	click on button    KPI View - Node >>
	verify the page title    KPI View - Node
	select a KPI    EN-DC Setup Success Rate captured in eNodeB
	select cells on the Node chart
	click on button    KPI View - Cell >>
	verify the page title    KPI View - Cell
	select cells
	click on button    Filtered Data >>
	verify the page title    Filtered Data
	verify that the rows are not empty
	Capture page screenshot
	[Teardown]    Test teardown		