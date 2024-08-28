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

Verify NR KPI Dashboard Page
    open nr kpi dashboard
    click on the scroll down button    0    20
    click on button    KPI Dashboard
    verify the page title    KPI Dashboard
    verify that the KPIs are present in KPI Dashboard page
    [Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots