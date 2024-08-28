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

Verify Settings Page
    open nr kpi dashboard
	Go to home page if not already at home
	Click on the scroll down button    0    20
	click on the button    Refresh
	click on the button    Settings
	verify the page title    KPI Dashboard Selection Settings
	click on the scroll down button    6    30
	click on button    Clear
	click on button		KPI Configuration Settings >>
	verify the page title    KPI Configuration Settings
	click on the button		Home
	verify the page title    Home		 
    [Teardown]    Test teardown

*** Keywords ***
	
Test teardown
    Capture page screenshot
    Close Browser

Suite setup steps
    Set Screenshot Directory   ./Screenshots