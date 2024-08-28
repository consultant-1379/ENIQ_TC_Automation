*** Settings ***

Library           OperatingSystem
Library           Selenium2Library
Library           Collections
Library           String
Library           DateTime
Library           PostgreSQLDB
Library           DatabaseLibrary
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/NR_SA_KPI_Dashboard_WebUI.robot
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/Variables.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Verification Of Node View Filtered Data Page
    open NR SA KPI Dashboard
    Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    ResetFilters & Markings
	click on button    Node View
	verify the page title    KPI View - Node
	click on the button    Random Access Success Rate Captured in gNodeB
	make selection on Selected Nodes
	verify that the rows are marked
	click on button    KPI View - Cell >>
	verify the page title    KPI View - Cell
	make selection on Cell View
	verify that the rows are marked
	click on button    Filtered Data >>
	verify the page title    Filtered Data - Node view
	click on button    << KPI View - Cell
	verify the page title    KPI View - Cell
	click on button    Filtered Data >>
	verify the page title    Filtered Data - Node view
	click on the button    Home
	verify the page title    Home
	[Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots
    
