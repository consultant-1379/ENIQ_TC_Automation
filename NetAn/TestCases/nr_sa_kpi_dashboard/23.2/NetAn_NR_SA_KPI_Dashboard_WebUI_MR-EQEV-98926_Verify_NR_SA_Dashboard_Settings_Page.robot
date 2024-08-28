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

Verify NR SA Dashboard Settings Page
    open NR SA KPI Dashboard
    Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    ResetFilters & Markings
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	verify that 12 KPIs can be selected at a time
	click on the scroll down button    5    30
	click on button    Clear
	click on button		KPI Dashboard >>
	verify the page title    KPI Dashboard
	click on the button		Home
	verify the page title    Home
    [Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots