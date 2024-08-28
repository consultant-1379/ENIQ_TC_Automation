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
Resource          ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Keywords/SybaseDBConnection.robot
Suite setup       Suite setup steps
Suite teardown    Suite teardown steps

*** Test Cases ***

Data Validation For Worst Performing cells Chart
    open NR SA KPI Dashboard
    Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    ResetFilters & Markings
	click on button    KPI Dashboard
	verify the page title    KPI Dashboard
	open KPI Details page for the KPI    Random Access Success Rate Captured in gNodeB
	${worstPerformingCellsValue}=    record tooltip values from Worst Performing Cells chart
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-sa-kpi-dashboard/NR_SA_KPI_Dashboard.json    Random_Access_Success_Rate_Captured_in_gNodeB
	Query ENIQ database and compare Worst Performing Cells values    ${sql_query}    ${worstPerformingCellsValue}
	[Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots
    
