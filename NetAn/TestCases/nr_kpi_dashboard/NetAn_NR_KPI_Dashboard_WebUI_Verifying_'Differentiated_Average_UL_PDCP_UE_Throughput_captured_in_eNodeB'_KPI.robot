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

Verifying "Differentiated Average UL PDCP UE Throughput captured in eNodeB" KPI
	open nr kpi dashboard
	Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    Refresh
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	click on the scroll down button    6    30
	click on button    Clear
	${KPI}=    add the KPI to selected KPIs    Differentiated Average UL PDCP UE Throughput captured in eNodeB
	verify the page title    KPI Dashboard
	open the KPI Details page for the Selected KPI
	verify the page title    KPI Details
	validate the chart title    ${KPI}
	click on button    Filtered Data >>
	verify the page title    Filtered Data
	verify that the rows are not empty
	Capture page screenshot
	[Teardown]    Test teardown		