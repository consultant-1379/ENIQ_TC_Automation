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

Data Validation Of KPI View Cell Page
    open NR SA KPI Dashboard
    Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    ResetFilters & Markings
	click on button    Node View
	verify the page title    KPI View - Node
	click on the button    Random Access Success Rate Captured in gNodeB
	click on button    KPI View - Cell >>
	verify the page title    KPI View - Cell
	make selection on Cell View chart
	verify that the rows are marked
	${datetime}    ${nrName}=    read the tooltip values from KPI View - Cell chart
	${sql_query}=      get sql query from json file    ${EXEC_DIR}/ENIQ_TC_Automation/NetAn/Resources/Data/nr-sa-kpi-dashboard/NR_SA_KPI_Dashboard.json    Random_Access_Success_Rate_Captured_in_gNodeB_TC_11
	Query ENIQ database and compare both the Worst Performing Cell values    ${sql_query}    ${dateTime}    ${nrName}
	[Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots
    
